
import Foundation

extension Character {
    var scrabbleScore: Int {
        switch self {
        case "A", "E", "I", "O", "U", "L", "N", "R", "S", "T":
            return 1
        case "D", "G":
            return 2
        case "B", "C", "M", "P":
            return 3
        case "F", "H", "V", "W", "Y":
            return 4
        case "K":
            return 5
        case "J", "X":
            return 8
        case "Q", "Z":
            return 10
        default:
            return 0
        }
    }
}

extension Character {
    var wordsWithFriendsScore: Int {
        switch self {
        case "A", "E", "I", "O", "T", "R", "S":
            return 1
        case "D", "N", "L", "U":
            return 2
        case "H", "G", "Y":
            return 3
        case "B", "C", "F", "M", "P", "W":
            return 4
        case "V", "K":
            return 5
        case "X":
            return 8
        case "J", "Q", "Z":
            return 10
        default:
            return 0
        }
    }
}
