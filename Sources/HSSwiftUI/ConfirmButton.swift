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

@available(macOS 13, iOS 16, tvOS 16, *)
public struct ConfirmButton<Label>: View where Label: View {
    public init(
        confirmTitle: LocalizedStringResource,
        confirmMessage: LocalizedStringResource,
        confirmButtonText: LocalizedStringResource,
        action: @escaping @MainActor () -> Void,
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
    let action: @MainActor () -> Void
    @ViewBuilder let label: () -> Label

    public var body: some View {
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
