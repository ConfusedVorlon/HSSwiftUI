//
//  File.swift
//  
//
//  Created by Rob Jonson on 05/10/2020.
//

import Foundation
import SwiftUI

public extension PreviewLayout {
    init(fixedSize:CGSize) {
        self = PreviewLayout.fixed(width: fixedSize.width, height: fixedSize.height)
    }
}


public extension Extensions {
    
    class PreviewLayout {
        
        /// Convenience initialiser
        public init(fixedSize:CGSize) {
            
        }
    }
}
