//
//  ObservableObject.swift
//  ResonateRemote
//
//  Created by Rob Jonson on 12/04/2022.
//

import Foundation
import Combine

public extension ObservableObject {
    /// Adds republishing support to enable nested ObservableObjects
    /// Send objectWillChange notification when the child sends objectWillChange
    ///
    /// this allows nested ObservableObjects to work with only the parent object being observed by your view
    /// - Parameter child: child ObservableObject
    /// - Returns: anyCancellable reference (save this)
    func republishObservable<Child: ObservableObject>(child: Child) -> AnyCancellable {
        return child.objectWillChange
            .receive(on: DispatchQueue.main)
            .sink {
            [weak self] _ in
            if let publisher = self?.objectWillChange as? ObservableObjectPublisher {
                publisher.send()
            }
        }
    }
}
