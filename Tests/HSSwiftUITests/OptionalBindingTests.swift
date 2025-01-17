//
//  OptionalBindingTests.swift
//  HSSwiftUI
//
//  Created by Rob Jonson on 17/01/2025.
//


import Testing
@testable import HSSwiftUI

import SwiftUI

@Suite("Optional Binding Tests")
struct OptionalBindingTests {
    @Test("Basic optional binding behaves correctly")
    func testBasicOptionalBinding() throws {
        // Test nil case
        var optionalValue: String? = nil
        let binding = Binding(get: { optionalValue }, set: { optionalValue = $0 })
        let boolBinding = binding.boundAsBool()
        
        #expect(boolBinding.wrappedValue == false)
        
        // Test non-nil case
        optionalValue = "hello"
        #expect(boolBinding.wrappedValue == true)
        
        // Test setting to false
        boolBinding.wrappedValue = false
        #expect(optionalValue == nil)
    }
    
    @Test("Array binding handles nil, empty, and non-empty cases")
    func testArrayBinding() throws {
        // Test nil case
        var optionalArray: [Int]? = nil
        let binding = Binding(get: { optionalArray }, set: { optionalArray = $0 })
        let boolBinding = binding.boundAsBool()
        
        #expect(boolBinding.wrappedValue == false)
        
        // Test empty array
        optionalArray = []
        #expect(boolBinding.wrappedValue == false)
        
        // Test non-empty array
        optionalArray = [1, 2, 3]
        #expect(boolBinding.wrappedValue == true)
        
        // Test setting to false
        boolBinding.wrappedValue = false
        #expect(optionalArray == nil)
    }
    
    @Test("Set binding handles nil, empty, and non-empty cases")
    func testSetBinding() throws {
        // Test nil case
        var optionalSet: Set<Int>? = nil
        let binding = Binding(get: { optionalSet }, set: { optionalSet = $0 })
        let boolBinding = binding.boundAsBool()
        
        #expect(boolBinding.wrappedValue == false)
        
        // Test empty set
        optionalSet = []
        #expect(boolBinding.wrappedValue == false)
        
        // Test non-empty set
        optionalSet = [1, 2, 3]
        #expect(boolBinding.wrappedValue == true)
        
        // Test setting to false
        boolBinding.wrappedValue = false
        #expect(optionalSet == nil)
    }
    
    @Test("Setting to true logs error but doesn't change value")
    func testSettingToTrue() throws {
        var optionalArray: [Int]? = nil
        let binding = Binding(get: { optionalArray }, set: { optionalArray = $0 })
        let boolBinding = binding.boundAsBool()
        
        boolBinding.wrappedValue = true
        #expect(optionalArray == nil)
    }
    
    @Test("Empty string is treated as non-empty (true)")
    func testEmptyString() throws {
        var optionalString: String? = ""
        let binding = Binding(get: { optionalString }, set: { optionalString = $0 })
        let boolBinding = binding.boundAsBool()
        
        #expect(boolBinding.wrappedValue == true)
    }
}
