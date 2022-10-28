import Foundation

struct Sorting: Identifiable, Hashable {
    
    let id: Int
    
    static func == (lhs: Sorting, rhs: Sorting) -> Bool {
        return lhs.id == rhs.id
    }
    
    func hash(into hasher: inout Hasher) {
        hasher.combine(id)
    }
        
    let name: String
    let comparison: (String, String) -> Bool
}

class Sortings {
    
    static let list = [
        Sorting(id: 0, name: "Alphabetically", comparison: alphabeticallyPrecedes),
        Sorting(id: 1, name: "Reverse Alphabetically", comparison: alphabeticallySucceeds),
        Sorting(id: 2, name: "Shortest to Longest", comparison: stringPrecedesInLength),
        Sorting(id: 3, name: "Longest to Shortest", comparison: stringSucceedsInLength),
        Sorting(id: 4, name: "Scrabble Score", comparison: scrabbleSucceeds),
        Sorting(id: 5, name: "Words with Friends Score", comparison: wordsWithFriendsSucceeds)
    ]
    
}

func alphabeticallyPrecedes(_ s1: String, _ s2: String) -> Bool {
    return s1.uppercased() < s2.uppercased()
}

func alphabeticallySucceeds(_ s1: String, _ s2: String) -> Bool {
    return s1.uppercased() > s2.uppercased()
}

func stringPrecedesInLength(_ s1: String, _ s2: String) -> Bool {
    if s1.count == s2.count {
        return alphabeticallyPrecedes(s1, s2)
    }
    else {
        return s1.count < s2.count
    }
}

func stringSucceedsInLength(_ s1: String, _ s2: String) -> Bool {
    return !stringPrecedesInLength(s1, s2)
}

func scrabblePrecedes(_ s1: String, _ s2: String) -> Bool {
    return s1.scrabbleScore < s2.scrabbleScore
}

func scrabbleSucceeds(_ s1: String, _ s2: String) -> Bool {
    return s1.scrabbleScore > s2.scrabbleScore
}

func wordsWithFriendsPreceeds(_ s1: String, _ s2: String) -> Bool {
    return s1.wordsWithFriendsScore < s2.wordsWithFriendsScore
}

func wordsWithFriendsSucceeds(_ s1: String, _ s2: String) -> Bool {
    return s1.wordsWithFriendsScore > s2.wordsWithFriendsScore
}

