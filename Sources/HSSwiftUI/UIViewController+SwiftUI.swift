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
    func insert<Content>(swiftUIView rootView:Content, inUIView container:UIView) -> UIHostingController<Content> where Content : View {
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
    
    static func with<Content>(swiftUIView:Content) -> UIViewController where Content : View {
        let vc = UIViewController.init(nibName: nil, bundle: nil)
        vc.insert(swiftUIView: swiftUIView, inUIView: vc.view)
        return vc
    }
}

#endif
