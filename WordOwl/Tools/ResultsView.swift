//
//  ResultsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 18/01/2022.
//

import SwiftUI

struct ResultsView: View {
    
    var results: [String]
    
    var filters: [Filter]
    var dictionary: Dictionary
    var sorting: Sorting
    var resultDetailType: ResultDetailType
    
    @State private var showingExporter = false
    @State private var showingChecklistView = false
    
    @State private var resultsLoaded = false
    @State private var selections = [String: Bool]()
    
    @State private var currentPage = 0
    
    private let resultsPerPage = 100;
    
    var compoundSearch: Bool {
        return filters.count > 1
    }
    
    var canEnterChecklistView: Bool {
        return results.count < 500
    }
    
    var resultsOnPage: Int {
        return (min(((currentPage + 1) * resultsPerPage - 1), results.count - 1)) - (currentPage * resultsPerPage) + 1
    }
    
    var body: some View {
        ScrollViewReader { scroller in
            Form {
                if compoundSearch {
                    Section(header: Text("Filters")) {
                        
                        ForEach(filters) { filter in
                            DetailsPair(parameter: filter.tool.shortName + (filter.inverted ? " (Inverted)" : ""), value: styledAggregateInput(filter.aggregateInput, tool: filter.tool))
                        }
                    }
                }
                
                Section(header: Text("Search Details")) {
                    
                    if !compoundSearch {
                        DetailsPair(parameter: "Tool", value: filters[0].tool.shortName + (filters[0].inverted ? " (Inverted)" : ""))
                    }
                    DetailsPair(parameter: "Dictionary", value: dictionary.shortName)
                    
                    if !compoundSearch {
                        DetailsPair(parameter: filters[0].tool.promptName, value: styledAggregateInput(filters[0].aggregateInput, tool: filters[0].tool))
                        ToolResultsDetailsView(tool: filters[0].tool, aggregateInput: filters[0].aggregateInput)
                    }
                }
                
                Section
                {
                    if !results.isEmpty {
                        ForEach(results[(currentPage * resultsPerPage)...(min(((currentPage + 1) * resultsPerPage - 1), results.count - 1))], id: \.self) {result in
                            HStack {
                                if (showingChecklistView) {
                                    Image(systemName: self.selections[result] ?? false ? "checkmark.circle.fill" : "circle")
                                        .foregroundColor(selections[result] ?? false ? .green : .secondary)
                                }
                                Text(result.capitalized)
                                    .foregroundColor(((selections[result] ?? false) || !showingChecklistView) ? .primary : .secondary)
                                Spacer()
                                Text(resultDetailType.detail(result))
                            }
                            .contentShape(Rectangle())
                            .onTapGesture { toggleSelectionOf(result)}
                            .onLongPressGesture{ enterChecklistMode(result) }
                        }
    //                    VStack{
    //                        ForEach(results.sorted(by: sorting.comparison), id: \.self) {result in
    //                            HStack {
    //
    //                                // Checkbox
    //                                if (showingChecklistView) {
    //
    //                                    Image(systemName: self.selections[result] ?? false ? "checkmark.circle.fill" : "circle")
    //                                        .foregroundColor(selections[result] ?? false ? .green : .secondary)
    //                                }
    //
    //                                // Result
    //                                Text(result.capitalizingFirstLetter())
    //                                    .foregroundColor(((selections[result] ?? false) || !showingChecklistView) ? .primary : .secondary)
    //                                Spacer()
    //
    //                                // Result Detail
    //                                Text(resultDetailType.detail(result))
    //                                    .foregroundColor(.secondary)
    //
    //                            }
    //                            .contentShape(Rectangle())
    //                            .onTapGesture { toggleSelectionOf(result)}
    //                            .onLongPressGesture{ enterChecklistMode(result) }
    //                        }
    //                    }
                    }
                    else {
                        Text("No Results Found")
                            .foregroundColor(.secondary)
                    }
                } header: {
                    Group {
                        if results.count > resultsPerPage {
                            PageController(resultCount: results.count, resultsPerPage: resultsPerPage, currentPage: $currentPage)
                        }
                        else {
                            Text("\(results.count) Search Results")
                        }
                    }
                    .id(0)
                } footer: {
                    if resultsOnPage > 13 {
                        Button {
                            scroller.scrollTo(0, anchor: .bottom)
                        } label: {
                            HStack {
                                Spacer()
                                Label("Back to Top", systemImage: "arrow.up")
                                Spacer()
                            }
                            .padding(.vertical)
                        }
                    }
                }
                
                
    //             Done button
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
    //        List(results, id: \.self) {
    //            Text($0)
    //        }
    //        .id(UUID())
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button(action: {showShareSheet()}) {
                        Label(showingChecklistView ? "Export Selection" : "Export Results", systemImage: "square.and.arrow.up")
                    }
                }
            }
        }
//        .task {
//            await loadResults()
//            do {
//                try await Task.sleep(nanoseconds: 1500000000)
//                Task {
//                    await loadResults()
//                }
//            } catch {
//                results = [String]()
//            }
//        }
    }
    
//    func loadResults() async {
//        results = [String]()
//        if compoundSearch {
//            var dict = dictionary
//            results = dict.words
//            for filter in toollist.filters {
//                if filter.inverted {
//                    let resultsToRemove = await filter.tool.searchFunction(dict, filter.aggregateInput)
//                    let setToRemove = Set(resultsToRemove)
//                    var resultsSet = Set(results)
//                    resultsSet.subtract(setToRemove)
//                    results = Array(resultsSet)
//                }
//                else {
//                    results = await filter.tool.searchFunction(dict, filter.aggregateInput)
//                }
//                dict = CustomDictionary(words: results)
//            }
//        }
//        else {
//            await results = tool.searchFunction(dictionary, aggregateInput)
//        }
//        resultsLoaded = true
//    }
//
    private func selectAll() {
        performHaptic(.medium)
        for result in results {
            selections[result] = true
        }
    }

    private func deselectAll(playHaptic: Bool = false) {
        if playHaptic {
            performHaptic(.medium)
        }
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
            ResultsView(
                results: Dictionaries.testWords(51),
                filters: ToolList.exampleSimpleSearch(),
                dictionary: Dictionaries.list[1],
                sorting: Sortings.list[0],
                resultDetailType: ResultDetailTypes.list[0])
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

struct PageController: View {
    
    var resultCount: Int
    var resultsPerPage: Int
    @Binding var currentPage: Int
    
    var firstResultOnPage: Int {
        return currentPage * resultsPerPage + 1
    }
    
    var lastResultOnPage: Int {
        return min((currentPage + 1) * resultsPerPage, resultCount)
    }
    
    var pages: Int {
        return Int(ceil((Double(resultCount) / Double(resultsPerPage))))
    }
    
    var resultsOnPage: Int {
        return (min(((currentPage + 1) * resultsPerPage - 1), resultCount - 1)) - (currentPage * resultsPerPage) + 1
    }
    
    var caption: String {
        if resultsOnPage > 1 {
            return "Showing \(firstResultOnPage) to \(lastResultOnPage) of \(resultCount) Results"
        }
        else {
            return "Showing Result \(firstResultOnPage) of \(resultCount)"
        }
    }
    
    private func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) {
        let impactMed = UIImpactFeedbackGenerator(style: style)
        impactMed.impactOccurred()
    }
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text("Page \(currentPage + 1) of \(pages)")
                    .foregroundColor(.primary)
                    .font(.headline)
                Text(caption)
            }
            Spacer()
            Button {
                currentPage -= 1
                HapticsController.performHaptic(.light)
            } label: {
                Image(systemName: "chevron.left")
            }
                .disabled(currentPage == 0)
                .buttonStyle(BorderedButtonStyle())
//                .frame(width: 80, alignment: .leading)
            Button {
                HapticsController.performHaptic(.light)
                currentPage += 1
            } label: {
                Image(systemName: "chevron.right")
            }
                .disabled(currentPage + 1 == pages)
                .buttonStyle(BorderedButtonStyle())
//                .frame(width: 80, alignment: .trailing)
        }
//        .padding(.horizontal, -14)
        .padding(.vertical)
        .textCase(.none)
    }
}
