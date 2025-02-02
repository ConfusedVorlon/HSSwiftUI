/**
 Copyright 2020 Joseph Duffy

 Permission is hereby granted, free of charge, to any person obtaining a copy of this software and associated documentation files (the "Software"), to deal in the Software without restriction, including without limitation the rights to use, copy, modify, merge, publish, distribute, sublicense, and/or sell copies of the Software, and to permit persons to whom the Software is furnished to do so, subject to the following conditions:

 The above copyright notice and this permission notice shall be included in all copies or substantial portions of the Software.

 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.
*/

import os.log
import SwiftUI

extension Binding where Value == Bool {


    // Array version
    private init<Element>(mappedTo bindingToOptional: Binding<[Element]?>) {
        self.init(
            get: { bindingToOptional.wrappedValue?.isEmpty == false },
            set: { newValue in
                if !newValue {
                    bindingToOptional.wrappedValue = nil
                } else {
                    os_log(.error, "Cannot set to true")
                }
            }
        )
    }

    // Set version
    private init<Element: Hashable>(mappedTo bindingToOptional: Binding<Set<Element>?>) {
        self.init(
            get: {
                bindingToOptional.wrappedValue?.isEmpty == false
            },
            set: { newValue in
                if !newValue {
                    bindingToOptional.wrappedValue = nil
                } else {
                    os_log(.error, "Cannot set to true")
                }
            }
        )
    }
    
    // Base version for non-collections
    private init<Wrapped>(mappedTo bindingToOptional: Binding<Wrapped?>) {
        self.init(
            get: {
                bindingToOptional.wrappedValue != nil
            },
            set: { newValue in
                if !newValue {
                    bindingToOptional.wrappedValue = nil
                } else {
                    os_log(
                        .error,
                        "Optional binding mapped to optional has been set to `true`, which will have no effect. Current value: %@",
                        String(describing: bindingToOptional.wrappedValue)
                    )
                }
            }
        )
    }
}

extension Binding {
    /// Returns a binding by mapping this binding's value to a `Bool` that is
    /// `true` when the value is non-`nil` and non-empty (for collections) and
    /// `false` when the value is `nil` or empty.
    ///
    /// When the value of the produced binding is set to `false` this binding's value
    /// is set to `nil`.
    public func boundAsBool<Wrapped>() -> Binding<Bool> where Value == Wrapped? {
        return Binding<Bool>(mappedTo: self)
    }
    
    /// Returns a binding by mapping this array binding's value to a `Bool` that is
    /// `true` when the array is non-`nil` and non-empty and `false` when the array
    /// is `nil` or empty.
    ///
    /// When the value of the produced binding is set to `false` this binding's value
    /// is set to `nil`.
    public func boundAsBool<Element>() -> Binding<Bool> where Value == [Element]? {
        return Binding<Bool>(mappedTo: self)
    }
    
    /// Returns a binding by mapping this set binding's value to a `Bool` that is
    /// `true` when the set is non-`nil` and non-empty and `false` when the set
    /// is `nil` or empty.
    ///
    /// When the value of the produced binding is set to `false` this binding's value
    /// is set to `nil`.
    public func boundAsBool<Element: Hashable>() -> Binding<Bool> where Value == Set<Element>? {
        return Binding<Bool>(mappedTo: self)
    }
}
