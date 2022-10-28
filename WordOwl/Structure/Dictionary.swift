import Foundation

struct Dictionary: Identifiable, Hashable {
    
    let id: String
    let name: String
    let shortName: String
    let titleName: String
    let path: String
    let symbolName: String?
    
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
}

func CustomDictionary(words: [String]) -> Dictionary {
    var dict = Dictionary(
        id: "Custom",
        name: "",
        shortName: "",
        titleName: "",
        path: "",
        symbolName: nil)
    dict.manualWords = words
    return dict
}

class Dictionaries {
    
    static let list = [
        Dictionary(
            id: "English",
            name: "English Dictionary",
            shortName: "English Dictionary",
            titleName: "English Dictionary",
            path: "EnglishDictionary.json",
            symbolName: nil),
        
        Dictionary(
            id: "Countries",
            name: "Countries of the World",
            shortName: "World Countries",
            titleName: "World Countries",
            path: "Countries.json",
            symbolName: "globe.europe.africa.fill"),
        
        Dictionary(
            id: "Elements", name: "Chemical Elements",
            shortName: "Elements",
            titleName: "Chemical Elements",
            path: "ChemicalElements.json",
            symbolName: "testtube.2"),
        
        Dictionary(
            id: "Animals", name: "Animals",
            shortName: "Animals",
            titleName: "Common Animals",
            path: "Animals.json",
            symbolName: "pawprint.fill"),
        
        /*
        
        Dictionary(
            id: "Cities", name: "Famous Cities",
            shortName: "Cities",
            titleName: "Famous Cities",
            path: "SmallSampleDictionary.json",
            symbolName: "building.2.fill")
        
        
        
        Dictionary(
            id: "Celebrities", name: "Celebrities",
            shortName: "Celebrities",
            titleName: "Celebrities",
            path: "SmallSampleDictionary.json",
            symbolName: "crown.fill"),
        
        Dictionary(
            id: "Body Parts", name: "Body Parts",
            shortName: "Body Parts",
            titleName: "Body Parts",
            path: "SmallSampleDictionary.json",
            symbolName: "eyebrow"),
        
        Dictionary(
            id: "Companies", name: "Companies",
            shortName: "Companies",
            titleName: "Major Companies",
            path: "SmallSampleDictionary.json",
            symbolName: "latch.2.case.fill")
         
         */
    ]
    
}
