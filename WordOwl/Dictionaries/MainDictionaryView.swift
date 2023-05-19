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
                        .onChange(of: dictionary) { _ in
                            if searchString.count > 0 {
                                Task {
                                    await searchDictionary()
                                }
                            }
                            else {
                                searchResults = Array(dictionary.words.prefix(maxLength + 1))
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
                    .padding(.horizontal, -14)
                    .padding(.bottom)
                    
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
            searchResults = Array(dictionary.words.prefix(maxLength + 1))
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
}

struct MainDictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            MainDictionaryView()
        }
    }
}
