//
//  ResultsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 18/01/2022.
//

import SwiftUI

struct ResultsView: View {
    
    @State private var showingExporter = false
    @State private var showingChecklistView = false
    
    var tool: Tool
    var dictionary: Dictionary
    var sorting: Sorting
    var resultDetailType: ResultDetailType
    var aggregateInput: AggregateInput
    var input: String
    
    // Detect if the search is a compound search
    var compoundSearch = false
    var toollist = ToolList()
    
    @State private var results: [String] = [String]()
    @State private var resultsLoaded = false
    @State private var selections = [String: Bool]()
    
    var canEnterChecklistView: Bool {
        return results.count < 500
    }
    
    var body: some View {
        Form {
            if compoundSearch {
                Section(header: Text("Filters")) {                                        
                    
                    ForEach(toollist.filters) { filter in
                        DetailsPair(parameter: filter.tool.shortName, value: styledAggregateInput(filter.aggregateInput, tool: filter.tool))
                    }
                }
            }
            else {
                Section(header: Text("Search Details")) {
                    
                    DetailsPair(parameter: "Tool", value: tool.shortName)
                    DetailsPair(parameter: "Dictionary", value: dictionary.shortName)
                    DetailsPair(parameter: tool.promptName, value: input)
                    
                    ToolResultsDetailsView(tool: tool, aggregateInput: aggregateInput)
                }
            }
            

            Section(
                header: Text(resultsLoaded && results.count > 0 ? "\(results.count) search results" : "search results"),
                footer: Text(resultsLoaded && results.count > 0 ? (showingChecklistView ? "" : (canEnterChecklistView ? "Long press a result to enter checklist mode." : "Checklist mode is unavailable for this quantity of results.")) : "").padding(.top)
            )
            {
                if resultsLoaded && !results.isEmpty {
                    ForEach(results.sorted(by: sorting.comparison), id: \.self) {result in
                        HStack {
                            
                            // Checkbox
                            if (showingChecklistView) {
                                                                
                                Image(systemName: self.selections[result] ?? false ? "checkmark.circle.fill" : "circle")
                                    .foregroundColor(selections[result] ?? false ? .green : .secondary)
                            }
                            
                            // Result
                            Text(result.capitalizingFirstLetter())
                                .foregroundColor(((selections[result] ?? false) || !showingChecklistView) ? .primary : .secondary)
                            Spacer()
                            
                            // Result Detail
                            Text(resultDetailType.detail(result))
                                .foregroundColor(.secondary)
                            
                        }
                        .contentShape(Rectangle())
                        .onTapGesture { toggleSelectionOf(result)}
                        .onLongPressGesture{ enterChecklistMode(result) }
                    }
                }
                else if resultsLoaded {
                    Text("No Results Found")
                        .foregroundColor(.secondary)
                }
                else {
                    HStack {
                        Text("Searching")
                            .foregroundColor(.secondary)
                        Spacer()
                        ProgressView()
                    }
                }
            }
            
            // Done button
            if (showingChecklistView) {
                // Section {
                    Button(action: exitChecklistMode) {
                        HStack {
                            Spacer()
                            Text("Done")
                            Spacer()
                        }
                    }
                // }
            }
        }
        .navigationTitle("Results")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {showShareSheet()}) {
                    Label(showingChecklistView ? "Export Selection" : "Export Results", systemImage: "square.and.arrow.up")
                }
            }
        }
        .onAppear {
            for result in results {
                selections[result] = false
            }
        }
        .task {
            getResults()
        }
    }
    
    private func getResults() {
        results = [String]()
        if compoundSearch {
            var dict = dictionary
            
            for filter in toollist.filters {
                results = filter.tool.searchFunction(dict, filter.aggregateInput)
                dict = CustomDictionary(words: results)
            }
        }
        else {
            results = tool.searchFunction(dictionary, aggregateInput)
        }
        resultsLoaded = true
    }
    
    private func selectAll() {
        performHaptic(.medium)
        for result in results {
            selections[result] = true
        }
    }
    
    private func deselectAll() {
        performHaptic(.medium)
        for result in results {
            selections[result] = false
        }
    }
    
    private func enterChecklistMode(_ result: String) {
        if canEnterChecklistView && !showingChecklistView {
            deselectAll()
            selections[result] = true
            withAnimation {
                showingChecklistView = true
            }
        }
    }
    
    private func exitChecklistMode() {
        deselectAll()
        withAnimation {
            showingChecklistView = false
        }
    }
    
    private func toggleSelectionOf(_ result: String) {
        if showingChecklistView {
            performHaptic(.medium)
            if selections[result] ?? false {
                selections[result] = false
            }
            else {
                selections[result] = true
            }
        }
    }
    
    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) {
        let impactMed = UIImpactFeedbackGenerator(style: style)
        impactMed.impactOccurred()
    }
    
    private func showShareSheet() {
        let text = textToExport()
        let activityVC = UIActivityViewController(activityItems: [text], applicationActivities: nil)
        UIApplication.shared.windows.first?.rootViewController?.present(activityVC, animated: true, completion: nil)
    }
    
    private func copyToClipboard() {
        let pasteboard = UIPasteboard.general
        pasteboard.string = textToExport()
    }
    
    private func textToExport() -> String {
        
        var format: (String) -> String {
            let icon = UserDefaults.standard.string(forKey: "selectedExportStyling")
            if icon == "AA" {
                return {word in return word.uppercased()}
            }
            if icon == "Aa" {
                return {word in return word.capitalizingFirstLetter()}
            }
            if icon == "aa" {
                return {word in return word.lowercased()}
            }
            else {
                return {word in return word}
            }
        }
        
        let delimeter = UserDefaults.standard.bool(forKey: "addNewLines") ? "\n" : ", "
        
        var output = ""
        var first = true
        for result in results {
            if !showingChecklistView || (selections[result] ?? false) {
                if !first {
                    output += delimeter
                }
                output += format(result)
                first = false
            }
        }
        return output
    }
}

struct ResultsView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResultsView(tool: Tools.anagramsTool, dictionary: Dictionaries.list[1], sorting: Sortings.list[0], resultDetailType: ResultDetailTypes.list[0], aggregateInput: AggregateInput(), input: "Paple")
        }
    }
}


/*
.contextMenu {
    Button {
        let pasteboard = UIPasteboard.general
        pasteboard.string = result.capitalizingFirstLetter()
    } label: {
        Label("Copy", systemImage: "doc.on.doc")
    }
    
    if results.count < 500 {
        Button {
            if (!showingChecklistView) {
                selections[result] = true
                withAnimation {
                    showingChecklistView = true
                }
            }
        } label: {
            Label("Select", systemImage: "checkmark.circle")
        }
    }
}
 */
