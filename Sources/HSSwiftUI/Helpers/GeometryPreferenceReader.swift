//
//  GeometryPreferenceReader.swift
//  layout
//
//  Created by Rob Jonson on 03/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

// https://finestructure.co/blog/2020/1/20/swiftui-equal-widths-view-constraints






import Foundation
import SwiftUI


/**
Read the geometry of a view and pass it up the hierarchy using preferences
 
to use:
 1) define an enum and a key
 
The key attribute defines the type of value that you are measuring
 
 - LatestCGFloat
 - MaxCGFloat
 - LatestCGRect
 - LatestEdgeInsets
 
 The value attribute should transform a GeometryProxy value into the value you are measuring
 
 ```
 //My key type is LatestHeightWidth - this is an identifier specific to my app/view
 enum LatestHeightWidth: Preference {}
     //latestHeight is my own variable name which I will read
     let latestHeight = GeometryPreferenceReader(
         //I want the latest value of a CGFloat. The generic type matches my key type
         key: LatestCGFloat<LatestHeightWidth>.self,
         //I can get the value I want from the GeometryProxy of the view with this transformer
         value: { $0.size.height }
    )
 ```
 
 2) read it somewhere (apply this modifier to the view you want to read values _from_
 ```
 //note I'm reading latestHeight which is the variable name I defined in my key
.read(latestHeight)
 ```
 
 3) write it out to a @State
 ```
@State var height: CGFloat? = nil

//apply this modifier to a container higher up in the view hierarchy
.assignPreference(for: latestHeight.key, to: $height)
 ```
*/
public struct GeometryPreferenceReader<K: PreferenceKey, V> where K.Value == V {
    public let key: K.Type
    public let value: (GeometryProxy) -> V
    
    public init(key: K.Type, value: @escaping (GeometryProxy) -> V) {
        self.key = key
        self.value = value
    }
}



public protocol Preference {}

/// Use this key type to measure a single value such as width or x-position
public struct LatestCGFloat<T: Preference>: PreferenceKey {
    public static var defaultValue: CGFloat? {nil}
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        let next = nextValue()
        if next == 0 {
            return
        }
        
        value = next ?? value
    }
    public typealias Value = CGFloat?
}

/// Use this key type to measure a maximum value over time
public struct MaxCGFloat<T: Preference>: PreferenceKey {
    public static var defaultValue: CGFloat? {nil}
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        guard let next = nextValue(), next != 0 else  { return }
        //if current value is nil, then use next
        value = max(next,value ?? next)
    }
    public typealias Value = CGFloat?
}

/// Use this key type to measure a rect such as frame
public struct LatestCGRect<T: Preference>: PreferenceKey {
    public static var defaultValue: CGRect? {nil}
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        guard let next = nextValue(), next != .zero else {return}
        value = next
    }
    public typealias Value = CGRect?
}

/// Use this key type to measure a edgeInsets (e.g. safe area)
public struct LatestEdgeInsets<T: Preference>: PreferenceKey {
    public static var defaultValue: EdgeInsets? {nil}
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        guard let next = nextValue(), next != EdgeInsets() else {return}
        value = next
    }
    public typealias Value = EdgeInsets?
}



public extension View {
    
    func assignPreference<K: PreferenceKey>(
        for key: K.Type,
        to binding: Binding<CGFloat?>) -> some View where K.Value == CGFloat? {
        
        return self.onPreferenceChange(key.self) { prefs in
            //print("\(key) -> \(prefs)")
            binding.wrappedValue = prefs
        }
    }
    
    func assignPreference<K: PreferenceKey>(
        for key: K.Type,
        to binding: Binding<CGRect?>) -> some View where K.Value == CGRect? {
        
        return self.onPreferenceChange(key.self) { prefs in
            //print("\(key) -> \(prefs)")
            binding.wrappedValue = prefs
        }
    }
    
    func assignPreference<K: PreferenceKey>(
        for key: K.Type,
        to binding: Binding<EdgeInsets?>) -> some View where K.Value == EdgeInsets? {
        
        return self.onPreferenceChange(key.self) { prefs in
            //print("\(key) -> \(prefs)")
            binding.wrappedValue = prefs
        }
    }
    
    func read<K: PreferenceKey, V>(_ preference: GeometryPreferenceReader<K, V>) -> some View {
        modifier(preference)
    }
}



// The view modifier applies a clear background to the view you are observing
// The background is wrapped in a GeometryReader to actually measure the size
extension GeometryPreferenceReader: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(GeometryReader {
                Color.clear.preference(key: self.key,
                                       value: self.value($0))
            })
    }
}
