//
//  AggregateInput.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 06/02/2022.
//

import Foundation

class AggregateInput : ObservableObject, Equatable {
    
    static func == (lhs: AggregateInput, rhs: AggregateInput) -> Bool {
        return lhs.inputStrings == rhs.inputStrings
            && lhs.inputInts == rhs.inputInts
            && lhs.inputBools == rhs.inputBools
            && lhs.inputCharacters == rhs.inputCharacters
    }
    
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
    
    var y: String {
        get {
            return inputStrings[1]
        }
        set(input) {
            inputStrings[1] = input
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
    
    func styledFor(tool: Tool) -> String {
        switch tool.input {
        case .string:
            if x.count > 0 {
                return "\"" + x.lowercased().capitalizingFirstLetter() + "\""
            }
            else {
                return "None"
            }
        case .number:
            return "\(i)"
        case .range:
            return "\(j) to \(i)"
        case .character:
            return a.rawValue
        case .spaces:
            var output = inputStrings[9].lowercased()
            if output.isEmpty {
                for i in 1...i {
                    let c = inputStrings[i-1].uppercased()
                    output += c == "" ? "?" : c
                    output += " "
                }
            }
            return output
        case .multipleCharacters:
            var output = ""
            var first = true
            for letter in EnglishAlphabet.allCases {
                if inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!] {
                    if !first {
                        output += ", "
                    }
                    output += letter.rawValue
                    first = false
                }
            }
            output = output.isEmpty ? "None" : output
            return output
        case .characterQuantities:
            var output = ""
            var first = true
            for letter in EnglishAlphabet.allCases {
                if inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!] {
                    if !first {
                        output += ", "
                    }
                    output += "\(inputInts[EnglishAlphabet.allCases.firstIndex(of: letter)!]) X "
                    output += letter.rawValue
                    first = false
                }
            }
            output = output.isEmpty ? "None" : output
            return output
        case .code:
            if x.count > 0 {
                return "\"" + x.lowercased() + "\""
            }
            else {
                return "None"
            }
        }
    }        
}
