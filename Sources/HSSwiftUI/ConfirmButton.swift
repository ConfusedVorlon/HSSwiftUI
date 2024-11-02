//
//  ConfirmButton.swift
//  HSSwiftUI
//
//  Created by Rob Jonson on 02/11/2024.
//


//
//  ConfirmButton.swift
//  FreeFallFilms
//
//  Created by Rob Jonson on 02/11/2024.
//

import SwiftUI
import HSHelpers

public struct ConfirmButton<Label>: View where Label: View {
    public init(
        confirmTitle: LocalizedStringResource,
        confirmMessage: LocalizedStringResource,
        confirmButtonText: LocalizedStringResource,
        action: @escaping MainAction,
        label: @escaping () -> Label
    ) {
        self.confirmTitle = confirmTitle
        self.confirmMessage = confirmMessage
        self.confirmButtonText = confirmButtonText
        self.action = action
        self.label = label
    }

    @State private var showConfirmAlert: Bool = false

    let confirmTitle: LocalizedStringResource
    let confirmMessage: LocalizedStringResource
    let confirmButtonText: LocalizedStringResource
    let action: MainAction
    @ViewBuilder let label: () -> Label

    var body: some View {
        Button {
            showConfirmAlert = true
        } label: {
            label()
        }
        .alert(isPresented: $showConfirmAlert) {
            Alert(
                title: Text(confirmTitle),
                message: Text(confirmMessage),
                primaryButton: .destructive(Text(confirmButtonText)) {
                    action()
                },
                secondaryButton: .cancel()
            )
        }

    }
}

#Preview {
    ConfirmButton(
        confirmTitle: "Confirm Please",
        confirmMessage: "This will do stuff",
        confirmButtonText: "Confirm",
        action: {
        }, label:
            {
                Text("Delete")
            }
    )
}
