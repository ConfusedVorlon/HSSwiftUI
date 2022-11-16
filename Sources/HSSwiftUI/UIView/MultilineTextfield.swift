//
//  MultilineTextfield.swift
//  Skydive Designer
//
//  Created by Rob Jonson on 22/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

//From  https://stackoverflow.com/questions/56471973/how-do-i-create-a-multiline-textfield-in-swiftui

#if canImport(UIKit)

import Foundation


import SwiftUI
import UIKit


public struct MultilineTextField: View {

    private var placeholder: String
    private var onDone: (() -> Void)?
    private var onChange: (() -> Void)?
    private var customise:((UITextView)->Void)?

    @Binding private var text: String
    private var internalText: Binding<String> {
        Binding<String>(get: { self.text } ) {
            self.text = $0
            self.showingPlaceholder = $0.isEmpty
        }
    }

    @State private var dynamicHeight: CGFloat = 100
    @State private var showingPlaceholder = false

    public init (_ placeholder: String = "",
                 text: Binding<String>,
                 onDone: (() -> Void)? = nil,
                 onChange: (() -> Void)? = nil,
                 customise:((UITextView)->Void)? = nil
    ) {
        self.placeholder = placeholder
        self.onDone = onDone
        self.onChange = onChange
        self.customise = customise
        self._text = text
        self._showingPlaceholder = State<Bool>(initialValue: self.text.isEmpty)
    }

    public var body: some View {
        UITextViewWrapper(text: self.internalText,
                          calculatedHeight: $dynamicHeight,
                          onDone: onDone,
                          onChange:onChange,
                          customise: customise
        )
            .frame(minHeight: dynamicHeight, maxHeight: dynamicHeight)
            .overlay(placeholderView, alignment: .topLeading)
    }

    var placeholderView: some View {
        Group {
            if showingPlaceholder {
                Text(placeholder).foregroundColor(.gray)
                    .padding(.leading, 4)
                    .padding(.top, 8)
            }
        }
    }
}

fileprivate struct UITextViewWrapper: UIViewRepresentable {
    typealias UIViewType = UITextView

    @Binding var text: String
    @Binding var calculatedHeight: CGFloat
    var onDone: (() -> Void)?
    var onChange: (() -> Void)?
    var customise:((UITextView)->Void)?
    

    func makeUIView(context: UIViewRepresentableContext<UITextViewWrapper>) -> UITextView {
        let textField = UITextView()
        textField.delegate = context.coordinator

        textField.isEditable = true
        textField.font = UIFont.preferredFont(forTextStyle: .body)
        textField.isSelectable = true
        textField.isUserInteractionEnabled = true
        textField.isScrollEnabled = false
        if nil != onDone {
            textField.returnKeyType = .done
        }

        textField.setContentCompressionResistancePriority(.defaultLow, for: .horizontal)
        customise?(textField)
        return textField
    }

    func updateUIView(_ uiView: UITextView, context: UIViewRepresentableContext<UITextViewWrapper>) {
        if uiView.text != self.text {
            uiView.text = self.text
        }
        if uiView.window != nil, !uiView.isFirstResponder {
            //This triggers attribute cycle if not dispatched
            DispatchQueue.main.async {
                uiView.becomeFirstResponder()
            }
        }
        UITextViewWrapper.recalculateHeight(view: uiView, result: $calculatedHeight)
    }

    fileprivate static func recalculateHeight(view: UIView, result: Binding<CGFloat>) {
        let newSize = view.sizeThatFits(CGSize(width: view.frame.size.width, height: CGFloat.greatestFiniteMagnitude))
        if result.wrappedValue != newSize.height {
            DispatchQueue.main.async {
                result.wrappedValue = newSize.height // !! must be called asynchronously
            }
        }
    }

    func makeCoordinator() -> Coordinator {
        return Coordinator(text: $text, height: $calculatedHeight, onDone: onDone, onChange: onChange)
    }

    final class Coordinator: NSObject, UITextViewDelegate {
        var text: Binding<String>
        var calculatedHeight: Binding<CGFloat>
        var onDone: (() -> Void)?
        var onChange: (() -> Void)?

        init(text: Binding<String>, height: Binding<CGFloat>, onDone: (() -> Void)? = nil, onChange: (() -> Void)? = nil ) {
            self.text = text
            self.calculatedHeight = height
            self.onDone = onDone
            self.onChange = onChange
        }

        func textViewDidChange(_ uiView: UITextView) {
            text.wrappedValue = uiView.text
            UITextViewWrapper.recalculateHeight(view: uiView, result: calculatedHeight)
            self.onChange?()
        }

        func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
            if let onDone = self.onDone, text == "\n" {
                textView.resignFirstResponder()
                onDone()
                return false
            }
            return true
        }
    }

}


#if DEBUG
struct MultilineTextField_Previews: PreviewProvider {
    static var test:String = ""//some very very very long description string to be initially wider than screen"
    static var testBinding = Binding<String>(get: { test }, set: {
//        print("New value: \($0)")
        test = $0 } )

    static var previews: some View {
        VStack(alignment: .leading) {
            Text("Description:")
            MultilineTextField("Enter some text here", text: testBinding, onDone: {
                print("Final text: \(test)")
            })
                .overlay(RoundedRectangle(cornerRadius: 4).stroke(Color.black))
            Text("Something static here...")
            Spacer()
        }
        .padding()
        //.previewDevice(.iPhone7)
    }
}
#endif


#endif
