//
//  Holder.swift
//
//  Created by Rob Jonson on 12/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import Foundation
import SwiftUI

/**
 Allows an observable object to be passed as an environment object without triggering view refresh when it changes

 this is useful when we want to be able to write to an object, or call methods - but don't read any values that change

 pass down with
 
     MyView().environmentObject(IsolatedObservable(MyObservable))
 
 then access with
 
     @EnvironmentObject var isolatedObservable:IsolatedObservable<MyObservable>
 
 and call the original object from your view  with
 
     isolatedObservable.object.someMethod()
 */
public class IsolatedObservable<T: ObservableObject>: ObservableObject {
    public var object: T

    public init(_ object: T) {
        self.object = object
    }
}

extension View {
    // convenience method to add an object both as a regular environment object, and also in an isolated holder
    public func environmentAndIsolatedObject<T: ObservableObject>(_ object: T) -> some View {
        modifier(EnvironmentObjectAndIsolated(object: object))
    }
}

private struct EnvironmentObjectAndIsolated<T: ObservableObject>: ViewModifier {
    var object: T

    func body(content: Content) -> some View {
        content
            .environmentObject(object)
            .environmentObject(IsolatedObservable(object))
    }
}
