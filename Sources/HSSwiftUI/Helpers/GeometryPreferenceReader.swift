//
//  GeometryPreferenceReader.swift
//  layout
//
//  Created by Rob Jonson on 03/02/2020.
//  Copyright © 2020 HobbyistSoftware. All rights reserved.
//

// https://finestructure.co/blog/2020/1/20/swiftui-equal-widths-view-constraints

/*
 
 to use:
 1) define an enum and a key
 the type is defined in the key: attribute
 
 enum LatestHeightWidth: Preference {}
 let latestHeight = GeometryPreferenceReader(
     key: LatestCGFloat<LatestHeightWidth>.self,
     value: { $0.size.height }
 )
 
 2) read it somewhere
 .read(latestHeight)
 
 3) write it out to a @State
 
 @State var height: CGFloat? = nil
 
 .assignPreference(for: latestHeight.key, to: $height)
 
 
 */




import Foundation
import SwiftUI

public struct GeometryPreferenceReader<K: PreferenceKey, V> where K.Value == V {
    public let key: K.Type
    public let value: (GeometryProxy) -> V
    
    public init(key: K.Type, value: @escaping (GeometryProxy) -> V) {
        self.key = key
        self.value = value
    }
}

extension GeometryPreferenceReader: ViewModifier {
    public func body(content: Content) -> some View {
        content
            .background(GeometryReader {
                Color.clear.preference(key: self.key,
                                       value: self.value($0))
            })
    }
}

public protocol Preference {}

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

public struct MaxCGFloat<T: Preference>: PreferenceKey {
    public static var defaultValue: CGFloat? {nil}
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        guard let next = nextValue(), next != 0 else  { return }
        //if current value is nil, then use next
        value = max(next,value ?? next)
    }
    public typealias Value = CGFloat?
}

public struct LatestCGRect<T: Preference>: PreferenceKey {
    public static var defaultValue: CGRect? {nil}
    public static func reduce(value: inout Value, nextValue: () -> Value) {
        guard let next = nextValue(), next != .zero else {return}
        value = next
    }
    public typealias Value = CGRect?
}

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
