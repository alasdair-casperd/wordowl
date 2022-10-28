//
//  StringExtensions.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/01/2022.
//

import Foundation

extension String {
    func capitalizingFirstLetter() -> String {
        return prefix(1).capitalized + dropFirst()
    }

    mutating func capitalizeFirstLetter() {
        self = self.capitalizingFirstLetter()
    }
}

extension String {
    var scrabbleScore: Int {
        var score = 0
        for i in self.uppercased() {
            score += i.scrabbleScore
        }
        return score
    }
}

extension String {
    var wordsWithFriendsScore: Int {
        var score = 0
        for i in self.uppercased() {
            score += i.wordsWithFriendsScore
        }
        return score
    }
}

extension String {
    var letters: String {
        return String(unicodeScalars.filter(CharacterSet.letters.contains))
    }
}

extension String {
    var lettersOrQuestion: String {
        var lettersAndQuestion = CharacterSet.letters
        lettersAndQuestion.insert(charactersIn: "?")
        return String(unicodeScalars.filter(lettersAndQuestion.contains))
    }
}

extension String {
    func characterCount(of character: Character) -> Int {
        return reduce(0) {
            $1 == character ? $0 + 1 : $0
        }
    }
}

enum EnglishAlphabet: String, CaseIterable {
    case A = "A"
    case B = "B"
    case C = "C"
    case D = "D"
    case E = "E"
    case F = "F"
    case G = "G"
    case H = "H"
    case I = "I"
    case J = "J"
    case K = "K"
    case L = "L"
    case M = "M"
    case N = "N"
    case O = "O"
    case P = "P"
    case Q = "Q"
    case R = "R"
    case S = "S"
    case T = "T"
    case U = "U"
    case V = "V"
    case W = "W"
    case X = "X"
    case Y = "Y"
    case Z = "Z"
}


