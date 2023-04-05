import Foundation

struct Dictionary: Identifiable, Hashable {
    
    let id: String
    let name: String
    let shortName: String
    let titleName: String
    let description: String
    let path: String
    let symbolName: String?
    var wordCount: String?
    
    var manualWords: [String]? = nil
    
    var words: [String] {
        get {
            if manualWords != nil {
                return manualWords!
            }
            else {
                return Bundle.main.decodeDictionary(path)
            }
        }
    }
    
    static let mainDictionaries = [wordOwl, small]
    
    static let small = Dictionary(
        id: "Small",
        name: "Small Dictionary",
        shortName: "Small",
        titleName: "Small", description: "A relatively small dictionary containing the most common English words.",
        path: "SmallEnglishDictionary.json",
        symbolName: nil,
        wordCount: "65,000")
    
    static let large = Dictionary(
        id: "Large",
        name: "Large Dictionary",
        shortName: "Large",
        titleName: "Large", description: "A large dictionary containing even the most obscure English words.",
        path: "LargeEnglishDictionary.json",
        symbolName: nil)
    
    static let wordOwl = Dictionary(
        id: "WordOwl",
        name: "WordOwl Dictionary",
        shortName: "WordOwl",
        titleName: "WordOwl", description: "A large dictionary containing even the most obscure English words.",
        path: "Enable.json",
        symbolName: nil,
        wordCount: "173,000")
    
    static func testWords(_ length: Int = 100) -> [String] {
        var words = [String]()
        for i in 1...length {words.append("Word \(i)")}
        return words
    }
    static let countries = Dictionary(
        id: "Countries",
        name: "Countries of the World",
        shortName: "World Countries",
        titleName: "World Countries", description: "A list of all the countries of the world.",
        path: "Countries.json",
        symbolName: "globe.europe.africa.fill")
        
    static let elements = Dictionary(
        id: "Elements", name: "Chemical Elements",
        shortName: "Elements",
        titleName: "Chemical Elements", description: "A list of all of the chemical elements of the periodic table",
        path: "ChemicalElements.json",
        symbolName: "testtube.2")
        
    static let animals = Dictionary(
        id: "Animals", name: "Animals",
        shortName: "Animals",
        titleName: "Common Animals", description: "A list of some of our planets animal species.",
        path: "Animals.json",
        symbolName: "pawprint.fill")
}

func CustomDictionary(words: [String]) -> Dictionary {
    var dict = Dictionary(
        id: "Custom",
        name: "",
        shortName: "",
        titleName: "",
        description: "",
        path: "",
        symbolName: nil)
    dict.manualWords = words
    return dict
}
