//
//  File.swift
//  
//
//  Created by Rob Jonson on 18/02/2023.
//

import Foundation

/// Class to force DocC to generate documentation on other extensions
///
/// DocC refuses to generate documentation for extensions on classes outside the package
///
/// Much of this package is extensions, so we declare non-functional 'fake' classes and methods under the Extensions namespace
///
/// When you're using them - ignore the Extensions namespace.
///
/// This should be redundant from Swift 5.9 or so...
public class Extensions {
    public class View{}
    
}
