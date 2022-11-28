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


    func previewLayout(_ size: CGSize) -> some View {
        return self.previewLayout(.fixed(width: size.width, height: size.height))
    }

    func eraseToAnyView() -> AnyView {
        AnyView(self)
    }

}

