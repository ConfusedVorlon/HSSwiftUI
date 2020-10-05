//
//  Color+HS.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 10/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

#if canImport(AppKit)

import Foundation
import SwiftUI
import AppKit

typealias NSColour = NSColor
typealias Colour = Color

extension NSColour {
    var colour:Colour {
        return Colour(self)
    }
}

extension Colour {

    
    
    public static var textColor: Color { Color(NSColour.textColor) }
    public static var labelColor: Color { Color(NSColour.labelColor) }
    public static var secondaryLabelColor: Color { Color(NSColour.secondaryLabelColor) }
    public static var tertiaryLabelColor: Color { Color(NSColour.tertiaryLabelColor) }
    public static var quaternaryLabelColor: Color { Color(NSColour.quaternaryLabelColor) }
    public static var placeholderTextColor: Color { Color(NSColour.placeholderTextColor) }

    


}

#endif
