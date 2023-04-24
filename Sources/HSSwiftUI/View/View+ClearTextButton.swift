//
//  TextClearButton.swift
//  Skydive Designer
//
//  Created by Rob Jonson on 20/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//


import SwiftUI

public extension View {

    
    /// Add a clear button to a View. Most useful for TextField.
    /// Button only shows when text is non-nil
    /// - Parameter text: binding to text that can be cleared
    /// - Returns: modified view
    ///
    /// Example
    /**
     
     ```
     struct TestView: View {
         @State var text:String
         
         var body: some View {
             TextField("Enter Text", text: $text)
                 .clearTextButton(text: $text)
                 .padding(5)
                 .border(.gray)
         }
     }
     ```
     */
    @available(macOS 11.0, *)
    func clearTextButton(text:Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}

@available(macOS 11.0, *)
private struct ClearButton: ViewModifier {
    @Binding var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    private var showing:Bool {
        text != ""
    }
    
    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            // onTapGesture is better than a Button here when adding to a form
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .opacity(showing ? 1 : 0)
                .onTapGesture { self.text = "" }
                .animation(.easeInOut,value: showing)
        }
    }
}

