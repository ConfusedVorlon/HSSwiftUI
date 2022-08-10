//
//  Holder.swift
//
//  Created by Rob Jonson on 12/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

import Foundation
import SwiftUI


// Allows an observable object to be passed as an environment object
// - but without triggering view refresh when it changes
// this is useful when we want to be able to write to an object, or call methods - but don't read any values that change
//
// pass down with
// MyView().environmentObject(IsolatedObservable(MyObservable))
// then access with
// @EnvironmentObject var isolatedObservable:IsolatedObservable<MyObservable>
// and call the original object with
// isolatedObservable.object.someMethod()
class IsolatedObservable<T:ObservableObject>: ObservableObject {
    var object: T

    init(_ object: T) {
        self.object = object
    }
}


extension View {
    //convenience method to add an object both as a regular environment object, and also in an isolated holder
    func environmentAndIsolatedObject<T:ObservableObject>(_ object: T) -> some View {
        modifier(EnvironmentObjectAndIsolated(object: object))
    }
}

struct EnvironmentObjectAndIsolated<T:ObservableObject>: ViewModifier {
    var object: T

    func body(content: Content) -> some View {
        content
            .environmentObject(object)
            .environmentObject(IsolatedObservable(object))
    }
}
