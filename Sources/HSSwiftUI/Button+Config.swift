//
//  SwiftUIView.swift
//  
//
//  Created by Rob Jonson on 27/02/2023.
//

import SwiftUI

/// Button - but the label viewbuilder is given the button configuration directly
/// ```
///   ButtonBuilder {
///       print("pressed")
///   } label: { config in
///       Text(config.isPressed ? "Pressed" : "Press Me")
///   }
/// ```
///
/// Note that you are fully responsible for the presentation, including any variation when the button is pressed / disabled
public struct ButtonBuilder<Label: View>: View {

    public init(action: @escaping () -> Void,
                label: @escaping (ButtonStyleConfiguration) -> Label) {
        self.action = action
        self.label = label
    }

    public var action: () -> Void
    @ViewBuilder public var label: (ButtonStyleConfiguration) -> Label

    public var body: some View {
        Button {
            action()
        } label: {
            EmptyView()
        }
        .buttonStyle(ConfigButtonStyle(content: label))
    }
}

private struct ConfigButtonStyle<Label: View>: ButtonStyle {
    @ViewBuilder var content: (ButtonStyleConfiguration) -> Label

    func makeBody(configuration: Configuration) -> some View {
        content(configuration)
    }
}

@available(iOS 15.0, *)
struct ConfigButton_Previews: PreviewProvider {
    static var previews: some View {
        ButtonBuilder {
            print("pressed")
        } label: { config in
            Text(config.isPressed ? "Pressed" : "Press Me")
        }
        .frame(width: 300, height: 70)
        .border(.blue)
        .fullBackground(color: .gray)

    }
}
