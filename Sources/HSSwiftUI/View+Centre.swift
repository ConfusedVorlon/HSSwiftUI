//
//  View+Centre.swift
//  PuppySounds
//
//  Created by Rob Jonson on 14/04/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import SwiftUI

public extension View {
    func stackToCentre() -> some View {
        modifier(CenterModifier())
    }
}

private struct CenterModifier: ViewModifier {
    func body(content: Content) -> some View {
        HStack {
            Spacer()
            content
            Spacer()
        }
    }
}
