//
//  HSHostingController.swift
//  MultiMonitor
//
//  Created by Rob Jonson on 12/08/2021.
//

import Foundation
import SwiftUI

#if os(iOS) || os(tvOS)
    import UIKit
    public typealias ViewController = UIViewController
    public typealias HostingController = UIHostingController
#elseif os(OSX)
    import AppKit
    public typealias ViewController = NSViewController
    public typealias HostingController = NSHostingController
#endif

@available(*, deprecated, message: "Used by HSHostingController which is deprecated")
public class HSHostWrapper: ObservableObject {
    public weak var controller: ViewController?
}

/**
allows root view (and children) to access the hosting controller by adding
 
    @EnvironmentObject var host:HSHostWrapper
 
which can then be used like
 
    host.controller?.dismiss()
 */
@available(*, deprecated, message: "Use the UIViewController init(@ViewBuilder _ builder:...) method instead")
public class HSHostingController<Content>: HostingController<ModifiedContent<Content, SwiftUI._EnvironmentKeyWritingModifier<HSHostWrapper?>>> where Content: View {

    public init(rootView: Content) {
        let container = HSHostWrapper()
        let modified = rootView.environmentObject(container) as! ModifiedContent<Content, _EnvironmentKeyWritingModifier<HSHostWrapper?>>
        super.init(rootView: modified)
        container.controller = self
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
