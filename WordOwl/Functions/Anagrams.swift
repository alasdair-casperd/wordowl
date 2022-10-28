//
//  Anagrams.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/01/2022.
//

import Foundation

func findAnagrams(_ dictionary: Dictionary, _ aggregateInput: AggregateInput) -> [String] {
    let words = dictionary.words
    let anagrammedWord = aggregateInput.x.lowercased() as NSString
    let length = anagrammedWord.length
    var aDic = [unichar:Int]()
    for i in 0..<length {
        let c = anagrammedWord.character(at: i)
        aDic[c] = (aDic[c] ?? 0) + 1
    }
    print(aDic)
    let foundWords = words.filter {
        let string = $0.lowercased() as NSString
        guard length == string.length else { return false }
        print("\(string) has the correct length; proceding.")
        var bDic = [unichar:Int]()
        for i in 0..<length {
            let c = string.character(at: i)
            print(c)
            let count = (bDic[c] ?? 0) + 1
            print(count)
            print(aDic[c] ?? "Nope")
            if count > aDic[c] ?? 0 {
                return false
            }
            bDic[c] = count
        }
        return true
    }
    return foundWords
}
