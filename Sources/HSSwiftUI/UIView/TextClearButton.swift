//
//  TextClearButton.swift
//  Skydive Designer
//
//  Created by Rob Jonson on 20/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

#if canImport(UIKit)

import SwiftUI

public struct ClearButton: ViewModifier {
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

#endif
