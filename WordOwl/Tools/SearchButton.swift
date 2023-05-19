//
//  SearchButton.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 31/03/2023.
//

import SwiftUI

struct SearchButton: View {
    
    var filters: [Filter]
    
    var selectedDictionary: Dictionary
    var selectedSorting: Sorting
    var selectedResultDetailType: ResultDetailType
            
    var searchDisabled: Bool
    
    @State private var results = [String]()
    
    @State private var searchInitiated = false
    @State private var showingResults = false
    
    @State private var showingAlert = false
    
    var body: some View {
        Section {
            HStack {
                Spacer()
                Button {
                    Task {
                        await initiateSearch()
                    }
                } label: {
                    HStack {
                        ProgressView()
                            .opacity(0)
                        Spacer()
                        Text("Search for Words")
                        Spacer()
                        ProgressView()
                            .opacity(searchInitiated ? 1 : 0)
                    }
                }
                .disabled(searchDisabled || searchInitiated)
                Spacer()
            }
        } footer: {
            NavigationLink(
                destination:
                    ResultsView(
                        results: results,
                        filters: filters,
                        dictionary: selectedDictionary,
                        sorting: selectedSorting,
                        resultDetailType: selectedResultDetailType
                        ),
                isActive: $showingResults) {
                EmptyView()
            }
        }
        .alert("No Search Results", isPresented: $showingAlert) {
            Button("OK") {}
        } message: {
            if selectedDictionary == Dictionary.small {
                Text("Consider searching the main dictionary.")
            }
            else {
                EmptyView()
            }
        }
    }
    
    func filteredResults(_ filter: Filter, input inputWords: [String]) async -> [String] {
            
        // print("Applying \(filter.tool.name) filter.")
        
        var results = [String]()
        
        if filter.inverted {
            results = inputWords
            let resultsToRemove = await filter.tool.searchFunction(inputWords, filter.aggregateInput)
            let setToRemove = Set(resultsToRemove)
            var resultsSet = Set(results)
            resultsSet.subtract(setToRemove)
            results = Array(resultsSet)
        }
        else {
            results = await filter.tool.searchFunction(inputWords, filter.aggregateInput)
        }
        return results
    }
    
    func initiateSearch() async {
        
        let key = "totalSearches"
        UserDefaults.standard.set(UserDefaults.standard.integer(forKey: key) + 1, forKey: key)
        
        var words = selectedDictionary.words
        searchInitiated = true
        
        for filter in filters {
            words = await filteredResults(filter, input: words)
        }
                
        words = words.sorted(by: selectedSorting.comparison)
        results = words
        searchInitiated = false
        
        if results.count > 0 {
            showingResults = true
        }
        else {
            showingAlert = true
        }
    }
}

//struct SearchButton_Previews: PreviewProvider {
//    static var previews: some View {
//        SearchButton()
//    }
//}
