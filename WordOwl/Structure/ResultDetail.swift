//
//  ResultDetail.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 01/02/2022.
//

struct ResultDetailType: Identifiable, Hashable {
    
    let id: Int
    
    static func == (lhs: ResultDetailType, rhs: ResultDetailType) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
    
    let name: String
    
    let detail: (String) -> String
}

class ResultDetailTypes {
    
    static let list = [
        ResultDetailType(id: 0, name: "None", detail: {_ in return ""}),
        ResultDetailType(id: 1, name: "Word Length", detail: {string in return "\(string.count)"}),
        ResultDetailType(id: 2, name: "Scrabble Score", detail: {string in return "\(string.scrabbleScore)"}),
        ResultDetailType(id: 3, name: "Words With Friends Score", detail: {string in return "\(string.wordsWithFriendsScore)"})
    ]
    
}
