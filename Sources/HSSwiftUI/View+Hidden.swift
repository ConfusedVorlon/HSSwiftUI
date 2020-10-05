//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/10/2020.
//

import Foundation
import SwiftUI


public extension View {

    /// Whether the view is hidden.
    /// - Parameter hide: Set to `true` to hide the view. Set to `false` to show the view.
    /// - Parameter shrinkSize: size when hidden or nil to ignore
    /// - Returns: view (or not)
    func isHidden(_ hide: Bool, shrinkSize:CGSize? = nil) -> some View {
        modifier(HiddenModifier(isHidden: hide,shrinkSize: shrinkSize))
    }
}

/// Variables can be used in place so that the content can be changed dynamically.
private struct HiddenModifier: ViewModifier {

    fileprivate let isHidden: Bool
    fileprivate let shrinkSize: CGSize?

    fileprivate func body(content: Content) -> some View {
        Group {
            if isHidden {
                content.hidden().frame(width: shrinkSize?.width, height: shrinkSize?.height)
            } else {
                content
            }
        }
    }
}
