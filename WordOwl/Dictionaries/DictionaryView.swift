//
//  DictionaryView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/01/2022.
//

import SwiftUI

struct DictionaryView: View {
        
    var dictionary: Dictionary
        
    private let maxLength = 100
    
    @State private var searchString = ""
    @State private var searchResults = [String]()
    @State private var searchInProgress = false
    
    var body: some View {
        ScrollViewReader { scroller in
            Form {
                Section {
                    if searchResults.count > 0 {
                        ForEach(searchResults.prefix(maxLength), id: \.self) { result in
                            Text(result.capitalized)
                        }
                    }
                    else {
                        Text("No Search Results")
                            .foregroundColor(.secondary)
                    }
                } header: {
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
                    .textCase(.none)
                    .font(.body)
                    .padding(.horizontal, -20)
                    .padding(.bottom, 8)
                }
            }
            .navigationTitle(dictionary.titleName)
        }
        .onAppear {
            searchResults = Array(dictionary.words.prefix(maxLength))
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

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView(dictionary: Dictionary.mainDictionaries[1])
    }
}
