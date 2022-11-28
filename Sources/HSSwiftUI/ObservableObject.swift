//
//  ObservableObject.swift
//  ResonateRemote
//
//  Created by Rob Jonson on 12/04/2022.
//

import Foundation
import Combine

public extension ObservableObject {
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
