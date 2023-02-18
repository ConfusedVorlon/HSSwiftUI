//
//  Color+HS.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 10/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

#if os(macOS)

import Foundation
import SwiftUI
import AppKit



public extension NSColor {
    var color:Color {
        return Color(self)
    }
}

extension Color {

    public static var textColor: Color { Color(NSColor.textColor) }
    public static var labelColor: Color { Color(NSColor.labelColor) }
    public static var secondaryLabelColor: Color { Color(NSColor.secondaryLabelColor) }
    public static var tertiaryLabelColor: Color { Color(NSColor.tertiaryLabelColor) }
    public static var quaternaryLabelColor: Color { Color(NSColor.quaternaryLabelColor) }
    public static var placeholderTextColor: Color { Color(NSColor.placeholderTextColor) }

}

#endif
