//
//  UIViewController+SwiftUI.swift
//  MilkoJumps
//
//  Created by Rob Jonson on 27/01/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//
#if canImport(UIKit)


import Foundation
import SwiftUI
import UIKit

public extension UIViewController {
    
    @discardableResult
    func insert<Content:View>(swiftUIView rootView:Content,
                         inUIView container:UIView) -> UIHostingController<Content> {
        let childVC = UIHostingController(rootView: rootView)
        
        self.addChild(childVC)
        childVC.view.frame = container.bounds
        container.addSubview(childVC.view)
        childVC.didMove(toParent: self)
        
        if let view = childVC.view, let superview = view.superview {
            view.translatesAutoresizingMaskIntoConstraints = false;
            let constraints = [
                view.leftAnchor.constraint(equalTo: superview.leftAnchor),
                view.rightAnchor.constraint(equalTo: superview.rightAnchor),
                view.topAnchor.constraint(equalTo: superview.topAnchor),
                view.bottomAnchor.constraint(equalTo: superview.bottomAnchor),
            ]
            NSLayoutConstraint.activate(constraints)
        }

        
        return childVC
    }
    
    
    static func with<Content: View>(swiftUIView:Content) -> UIViewController  {
        let vc = UIViewController.init(nibName: nil, bundle: nil)
        vc.insert(swiftUIView: swiftUIView, inUIView: vc.view)
        return vc
    }
    
    /// Build a UIViewController which presents a SwiftUI View
    /// - Parameter builder: The builder gets a reference to the ViewController. This is useful for e.g. dismissal
    /// be careful not to strongly retain this!
    convenience init<Content:View>(@ViewBuilder _ builder: @MainActor(UIViewController)->Content) {
        self.init(nibName: nil, bundle: nil)
        let swiftUIView = builder(self)
        self.insert(swiftUIView: swiftUIView, inUIView: self.view)
    }
}

#endif
