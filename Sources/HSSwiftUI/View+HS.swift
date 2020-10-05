//
//  View+HS.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 19/01/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//


import Foundation
import SwiftUI

extension View {
    
    public func frame(size: CGSize, alignment: Alignment = .center) -> some View {
        return frame(width: size.width, height: size.height, alignment: alignment)
    }

    func fillParent(alignment:Alignment = .center) -> some View {
        return GeometryReader { geometry in
            self
                .frame(size: geometry.size, alignment: alignment)
        }
    }
    

    //https://forums.swift.org/t/conditionally-apply-modifier-in-swiftui/32815/16
//    @ViewBuilder
//    func `if`<T>(_ condition: Bool, transform: (Self) -> T) -> some View where T : View {
//        if condition {
//            transform(self)
//        } else {
//            self
//        }
//    }
    

    func previewLayout(_ size: CGSize) -> some View {
        return self.previewLayout(.fixed(width: size.width, height: size.height))
    }

    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

}

extension PreviewLayout {
    init(fixedSize:CGSize) {
        self = PreviewLayout.fixed(width: fixedSize.width, height: fixedSize.height)
    }
}




extension View {

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

//extension View {
//
//    /// Whether the view is hidden.
//    /// - Parameter bool: Set to `true` to hide the view. Set to `false` to show the view.
//    func run(_ code: @escaping () -> ()) -> some View {
//        modifier(CodeModifier(code: code))
//    }
//}
//
//private struct CodeModifier: ViewModifier {
//
//    fileprivate let code: () -> ()
//
//    func check() -> CGSize {
//        code()
//        return .zero
//    }
//
//    fileprivate func body(content: Content) -> some View {
//        return content.offset(check())
//    }
//}
