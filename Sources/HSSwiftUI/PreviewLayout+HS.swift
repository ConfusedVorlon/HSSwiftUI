//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/10/2020.
//

import Foundation
import SwiftUI

public extension PreviewLayout {
    /// Convenience initialiser for PreviewLayout
    /// - Parameter fixedSize: size
    init(fixedSize:CGSize) {
        self = PreviewLayout.fixed(width: fixedSize.width, height: fixedSize.height)
    }
}

