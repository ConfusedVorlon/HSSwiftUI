//
//  KeyboardVisibility.swift
//  Chatter
//
//  Created by Rob Jonson on 16/04/2023.
//

import SwiftUI
import Combine




public extension View {
    /// Sets an environment value for keyboardShowing
    /// Access this in any child view with
    /// @Environment(\.keyboardShowing) var keyboardShowing
    /// You should add the modifier near the top of your view hierarchy (to RootView / ContentView or similar)
    /// On MacOS, this is always false
    func addKeyboardVisibilityToEnvironment() -> some View {
        modifier(KeyboardVisibility())
    }
}

private struct KeyboardShowingEnvironmentKey: EnvironmentKey {
    static let defaultValue: Bool = false
}

public extension EnvironmentValues {
    
    /// Apply addKeyboardVisibilityToEnvironment near the top of your view hierarchy to enable this environment key
    var keyboardShowing: Bool {
        get { self[KeyboardShowingEnvironmentKey.self] }
        set { self[KeyboardShowingEnvironmentKey.self] = newValue }
    }
}

private struct KeyboardVisibility:ViewModifier {
    
#if os(macOS)
    
    fileprivate func body(content: Content) -> some View {
        content
            .environment(\.keyboardShowing, false)
    }
    
#else
    
    @State var isKeyboardShowing:Bool = false
    
    private var keyboardPublisher: AnyPublisher<Bool, Never> {
        Publishers
            .Merge(
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardWillShowNotification)
                    .map { _ in true },
                NotificationCenter
                    .default
                    .publisher(for: UIResponder.keyboardDidHideNotification)
                    .map { _ in false })
            .debounce(for: .seconds(0.1), scheduler: RunLoop.main)
            .eraseToAnyPublisher()
    }
    
    fileprivate func body(content: Content) -> some View {
        content
            .environment(\.keyboardShowing, isKeyboardShowing)
            .onReceive(keyboardPublisher) { value in
                isKeyboardShowing = value
            }
    }
    
#endif
}
