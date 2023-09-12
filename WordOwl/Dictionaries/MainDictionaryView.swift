//
//  MainDictionaryView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 16/05/2023.
//

import SwiftUI

struct MainDictionaryView: View {
        
    private let maxLength = 100
    
    @State private var dictionary = Dictionary.wordOwl
    
    @State private var searchString = ""
    @State private var searchResults = [String]()
    @State private var searchInProgress = false
    
    @Environment(\.openURL) var openURL
    
    @State private var showingDefinition = false
    @State private var wordToDefine = ""
    
    var body: some View {
        
        ScrollViewReader { scroller in
            Form {
                Section {
                    if searchResults.count > 0 {
                        ForEach(searchResults.prefix(maxLength), id: \.self) { result in
                            Text(result.capitalized)
                            .contextMenu {
                                Button {
                                    let pasteboard = UIPasteboard.general
                                    pasteboard.string = result.capitalized
                                } label: {
                                    Label("Copy", systemImage: "doc.on.doc")
                                }

                                if !iPadVersion {
                                    Button {
                                        if UIReferenceLibraryViewController.dictionaryHasDefinition(forTerm: result) {
                                            wordToDefine = result
                                            showingDefinition = true
                                        }
                                        else {
                                            openURL(URL(string: "https://www.google.com/search?q=" + result)!)
                                        }
                                    } label: {
                                        Label("Define", systemImage: "text.magnifyingglass")
                                    }
                                }
                            }
                        }
                    }
                    else {
                        Text("No Search Results")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    VStack {
                        Picker("Choose Dictionary", selection: $dictionary) {
                            ForEach(Dictionary.mainDictionaries.reversed()) { dictionary in
                                Text(dictionary.shortName)
                                    .tag(dictionary)
                            }
                        }
                        .onChange(of: dictionary) { newDictionary in
                            searchString = ""
                            if newDictionary == .wordOwl {
                                searchResults = wordOwl100
                            }
                            else {
                                searchResults = small100
                            }
                        }
                        .pickerStyle(SegmentedPickerStyle())
                        
                        HStack {
                            Text(dictionary.description)
                                .padding(.vertical)
                                .foregroundColor(.primary)
                            Spacer()
                        }
                        HStack {
                            TextField("Search for a word...", text: $searchString)
                                .onSubmit {
                                    Task {
                                        await searchDictionary()
                                    }
                                }
                                .id(0)
                                .keyboardType(.alphabet)
                                .submitLabel(.search)
                            Spacer()
                            if searchInProgress {
                                ProgressView()
                            }
                        }
                        .icon("magnifyingglass", color: .secondary)
                        .padding(8)
                        .background {
                            Rectangle()
                                .foregroundColor(.secondaryBackgroundColor)
                                .cornerRadius(10)
                        }
                    }
                    .textCase(.none)
                    .font(.body)
                    .padding(.bottom)
                    .listRowInsets(EdgeInsets.none)
                    
                } footer: {
                    if searchResults.count >= maxLength - 1 {
                        (Text("Further results have not been displayed. To view more words, use the ") + Text(Image(systemName: "magnifyingglass")) + Text(" Search tab."))
                            .padding(.bottom)
                    }
                }
            }
            .navigationTitle("Dictionary")
        }
        .onAppear {
            searchResults = wordOwl100 //Array(dictionary.words.prefix(maxLength + 1))
            wordToDefine = ""
        }
        .sheet(isPresented: $showingDefinition) {
            DefinitionView(word: $wordToDefine)
        }
        
    }
    
    func searchDictionary() async {
        searchInProgress = true
        let aggregateInput = AggregateInput()
        aggregateInput.x = searchString
        await searchResults = Tool.startingStringTool.searchFunction(dictionary.words, aggregateInput)
        searchInProgress = false
    }
    
    let wordOwl100 = [
        "a",
        "aa",
        "aah",
        "aahed",
        "aahing",
        "aahs",
        "aal",
        "aalii",
        "aaliis",
        "aals",
        "aardvark",
        "aardvarks",
        "aardwolf",
        "aardwolves",
        "aargh",
        "aarrgh",
        "aarrghh",
        "aas",
        "aasvogel",
        "aasvogels",
        "ab",
        "aba",
        "abaca",
        "abacas",
        "abaci",
        "aback",
        "abacterial",
        "abacus",
        "abacuses",
        "abaft",
        "abaka",
        "abakas",
        "abalone",
        "abalones",
        "abamp",
        "abampere",
        "abamperes",
        "abamps",
        "abandon",
        "abandoned",
        "abandoner",
        "abandoners",
        "abandoning",
        "abandonment",
        "abandonments",
        "abandons",
        "abapical",
        "abas",
        "abase",
        "abased",
        "abasedly",
        "abasement",
        "abasements",
        "abaser",
        "abasers",
        "abases",
        "abash",
        "abashed",
        "abashes",
        "abashing",
        "abashment",
        "abashments",
        "abasia",
        "abasias",
        "abasing",
        "abatable",
        "abate",
        "abated",
        "abatement",
        "abatements",
        "abater",
        "abaters",
        "abates",
        "abating",
        "abatis",
        "abatises",
        "abator",
        "abators",
        "abattis",
        "abattises",
        "abattoir",
        "abattoirs",
        "abaxial",
        "abaxile",
        "abba",
        "abbacies",
        "abbacy",
        "abbas",
        "abbatial",
        "abbe",
        "abbes",
        "abbess",
        "abbesses",
        "abbey",
        "abbeys",
        "abbot",
        "abbotcies",
        "abbotcy",
        "abbots",
        "abbreviate"
    ]
    
    let small100 = [
        "a",
        "aachen",
        "aardvark",
        "aardvarks",
        "aaron",
        "aback",
        "abacus",
        "abacuses",
        "abaft",
        "abalone",
        "abandon",
        "abandoned",
        "abandoning",
        "abandonment",
        "abandons",
        "abase",
        "abased",
        "abasement",
        "abases",
        "abash",
        "abashed",
        "abasing",
        "abate",
        "abated",
        "abatement",
        "abatements",
        "abates",
        "abating",
        "abattoir",
        "abattoirs",
        "abbess",
        "abbesses",
        "abbey",
        "abbeys",
        "abbot",
        "abbots",
        "abbotsbury",
        "abbreviate",
        "abbreviated",
        "abbreviates",
        "abbreviating",
        "abbreviation",
        "abbreviations",
        "abdicant",
        "abdicants",
        "abdicate",
        "abdicated",
        "abdicates",
        "abdicating",
        "abdication",
        "abdications",
        "abdomen",
        "abdomens",
        "abdominal",
        "abdominally",
        "abduct",
        "abducted",
        "abducting",
        "abduction",
        "abductions",
        "abductor",
        "abductors",
        "abducts",
        "abe",
        "abeam",
        "abearances",
        "abed",
        "abel",
        "aberaeron",
        "aberavon",
        "aberdare",
        "aberdaron",
        "aberdeen",
        "aberdonian",
        "aberdonians",
        "aberdovey",
        "aberfeldy",
        "abergele",
        "aberrance",
        "aberrances",
        "aberrancy",
        "aberrant",
        "aberrate",
        "aberrated",
        "aberrates",
        "aberrating",
        "aberration",
        "aberrational",
        "aberrations",
        "abersoch",
        "abertilly",
        "aberystwyth",
        "abet",
        "abets",
        "abetted",
        "abetting",
        "abettor",
        "abettors",
        "abeyance",
        "abeyant"
    ]
}

struct MainDictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainDictionaryView()
        }
    }
}
