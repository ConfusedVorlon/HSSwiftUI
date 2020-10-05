//
//  View+HS.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 19/01/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//


import Foundation
import SwiftUI

public extension View {
    
    func frame(size: CGSize, alignment: Alignment = .center) -> some View {
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


//extension View {
//
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
