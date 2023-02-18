//
//  TextClearButton.swift
//  Skydive Designer
//
//  Created by Rob Jonson on 20/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//


import SwiftUI

extension View {
    @available(macOS 11.0, *)
    func clearTextButton(text:Binding<String>) -> some View {
        modifier(ClearButton(text: text))
    }
}

/** Add a clear button to a TextField
 
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
private struct ClearButton: ViewModifier {
    @Binding var text: String

    public init(text: Binding<String>) {
        self._text = text
    }

    public func body(content: Content) -> some View {
        HStack {
            content
            Spacer()
            // onTapGesture is better than a Button here when adding to a form
            Image(systemName: "multiply.circle.fill")
                .foregroundColor(.secondary)
                .opacity(text == "" ? 0 : 1)
                .onTapGesture { self.text = "" }
        }
    }
}

public extension Extensions.View {

/** Add a clear button to a View. Most useful for TextField
     
Button only shows when text is non-nil
     
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
    func clearTextButton(text:Binding<String>) -> some View {
            return EmptyView()
    }
}
