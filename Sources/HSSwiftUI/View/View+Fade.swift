//
//  FadeIf.swift
//  FadeIf
//
//  Created by Rob Jonson on 13/09/2021.
//  Copyright © 2021 HobbyistSoftware. All rights reserved.
//

import SwiftUI

public extension View {

    /// Whether the view is hidden.
    /// - Parameter fade: Set to `true` to hide the view. Set to `false` to show the view.
    /// - Parameter shrinkSize: size when hidden or nil to ignore
    /// - Returns: view (or not)
    func fadeIf(_ fade: Bool, fadedSize:CGSize? = nil) -> some View {
        modifier(FadeIfModifier(fade: fade,fadedSize: fadedSize))
    }
}

/// Variables can be used in place so that the content can be changed dynamically.
private struct FadeIfModifier: ViewModifier {

    fileprivate let fade: Bool
    fileprivate let fadedSize: CGSize?

    fileprivate func body(content: Content) -> some View {
        content
            .opacity(fade ? 0 : 1)
            .animation(.easeInOut(duration: 0.2),value: fade)
            .frame(width:fade ? fadedSize?.width : nil, height: fade ? fadedSize?.height : nil)
    }
}
