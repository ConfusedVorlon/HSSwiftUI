//
//  File.swift
//  
//
//  Created by Rob Jonson on 18/02/2023.
//

import Foundation
import SwiftUI

extension View {
    
    /// Sets an expansive background. Particularly useful in Previews
    /// - Parameter color: color
    /// - Returns: modified view
    public func fullBackground(color: Color) -> some View {
        modifier(FullBackground(color: color))
    }
}

/// Particularly seful to set the background in previews
private struct FullBackground: ViewModifier {
    var color: Color

    func body(content: Content) -> some View {
        ZStack(alignment: .center) {
            color.edgesIgnoringSafeArea(.all)

            content
        }
    }
}
