//
//  AggregateInput.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 06/02/2022.
//

import Foundation

class AggregateInput : ObservableObject {
    
    @Published var inputStrings: [String]
    @Published var inputInts: [Int]
    @Published var inputBools: [Bool]
    @Published var inputCharacters: [EnglishAlphabet]
    
    init(
        strings: [String],
        ints: [Int],
        bools: [Bool],
        characters: [EnglishAlphabet]
    ) {
        inputStrings = strings
        inputInts = ints
        inputBools = bools
        inputCharacters = characters
    }
    
    init() {
        inputStrings = Array(repeating: "", count: 45)
        inputInts = Array(repeating: 1, count: 45)
        inputBools = Array(repeating: false, count: 45)
        inputCharacters = Array(repeating: EnglishAlphabet.A, count: 45)
        
        inputInts[0] = 5
    }
    
    var i: Int {
        get {
            return inputInts[0]
        }
        set(input) {
            inputInts[0] = input
        }
    }
    
    var j: Int {
        get {
            return inputInts[1]
        }
        set(input) {
            inputInts[1] = input
        }
    }
    
    var x: String {
        get {
            return inputStrings[0]
        }
        set(input) {
            inputStrings[0] = input
        }
    }
    
    var a: EnglishAlphabet {
        get {
            return inputCharacters[0]
        }
        set(input) {
            inputCharacters[0] = input
        }
    }
}
