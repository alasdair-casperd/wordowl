import Foundation

struct Dictionary: Identifiable, Hashable {
    
    let id: String
    let name: String
    let shortName: String
    let titleName: String
    let description: String
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
        description: "",
        path: "",
        symbolName: nil)
    dict.manualWords = words
    return dict
}

class Dictionaries {
    
    static let list = [
        Dictionary(
            id: "Small",
            name: "Small Dictionary",
            shortName: "Small Dictionary",
            titleName: "Small Dictionary", description: "A relatively small dictionary containing the most common English words.",
            path: "SmallEnglishDictionary.json",
            symbolName: nil),
        
        Dictionary(
            id: "Large",
            name: "Large Dictionary",
            shortName: "Large Dictionary",
            titleName: "Large Dictionary", description: "A large dictionary containing even the most obscure English words.",
            path: "LargeEnglishDictionary.json",
            symbolName: nil),
        
//        Dictionary(
//            id: "Countries",
//            name: "Countries of the World",
//            shortName: "World Countries",
//            titleName: "World Countries", description: "A list of all the countries of the world.",
//            path: "Countries.json",
//            symbolName: "globe.europe.africa.fill"),
//        
//        Dictionary(
//            id: "Elements", name: "Chemical Elements",
//            shortName: "Elements",
//            titleName: "Chemical Elements", description: "A list of all of the chemical elements of the periodic table",
//            path: "ChemicalElements.json",
//            symbolName: "testtube.2"),
//        
//        Dictionary(
//            id: "Animals", name: "Animals",
//            shortName: "Animals",
//            titleName: "Common Animals", description: "A list of some of our planets animal species.",
//            path: "Animals.json",
//            symbolName: "pawprint.fill"),
        
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
