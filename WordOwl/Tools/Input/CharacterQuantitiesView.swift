//
//  CharacterQuantitiesView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 08/02/2022.
//

import SwiftUI

struct CharacterQuantitiesView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    @State private var inputText = ""
    @AppStorage("characterQuantitiesInputStyle") private var inputSyle = 1
    
    var body: some View {
        Section {
            if inputSyle == 1 {
                ForEach(0...25, id: \.self) { i in
                    if aggregateInput.inputBools[i] {
                        HStack {
                            Text("\(EnglishAlphabet.allCases[i].rawValue)")
                            + Text(" X \(aggregateInput.inputInts[i])")
                                .foregroundColor(.secondary)
                            Spacer()
                            Stepper("", value: $aggregateInput.inputInts[i], in: 1...10)
                        }
                    }
                }
                .onDelete(perform: removeRows)
                .onDisappear {
                    styleTextForAggregateInput()
                }
                NavigationLink(destination: MultipleCharactersDetailView(tool: Tool.containsOnlyTool, aggregateInput: aggregateInput)) {
                    Text(listNonEmpty() ? "Select Characters" : "Add Characters")
                }
            }
            else {
                TextField(tool.prompt[0], text: $inputText)
                    .onChange(of: inputText) { newValue in
                        styleAggregateInputForString(input: newValue)
                    }
            }
        } header: {
            VStack(alignment: .leading, spacing: 0) {
                ToolInstructionsView(tool: tool)
                Picker("Input Style", selection: $inputSyle) {
                    Text("Plain Text Input").tag(0)
                    Text("Character Picker").tag(1)
                }
                .onChange(of: inputSyle, perform: {_ in})
                .padding(.bottom)
                .textCase(.none)
                .pickerStyle(SegmentedPickerStyle())
            }
            .listRowInsets(EdgeInsets.none)
        }
        .onAppear {
            aggregateInput.inputInts[30] = UserDefaults.standard.integer(forKey: "quantityMode")
        }
    }

    func styleAggregateInputForString(input: String) {
        for c in EnglishAlphabet.allCases {
            let i = EnglishAlphabet.allCases.firstIndex(of: c)!
            aggregateInput.inputBools[i] = input.uppercased().contains(where: {a in return String(a) == c.rawValue})
            aggregateInput.inputInts[i] = input.uppercased().filter({String($0) == c.rawValue}).count
        }
    }
        
    func styleTextForAggregateInput() {
        var output = ""
        for c in EnglishAlphabet.allCases {
            let i = EnglishAlphabet.allCases.firstIndex(of: c)!
            if (aggregateInput.inputBools[i]) {
                for _ in 1...aggregateInput.inputInts[i] {
                    output += c.rawValue
                }
            }
        }
        inputText = output
    }
    
    func removeRows(at offsets: IndexSet) {
        for offset in offsets {
            aggregateInput.inputBools[offset] = false
        }
    }
    
    private func listNonEmpty() -> Bool {
        var output = false
        for i in 0...25 {
            if aggregateInput.inputBools[i] {
                output = true
                break
            }
        }
        return output
    }
}

struct CharacterQuantitiesSettingsView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    @AppStorage("allowOtherLetters") private var allowOtherLetters = false
    
    var body: some View {
        Section(header: Text("Tool Settings")) {
            Toggle("Allow Other Letters", isOn: $allowOtherLetters)
                .onChange(of: allowOtherLetters) { newValue in
                    aggregateInput.inputBools[31] = newValue
                }
            NavigationLink(destination: CharacterQuantitiesSettingsDetailView(tool: tool, aggregateInput: aggregateInput)) {
                HStack {
                    Text("Quantity Mode")
                    Spacer()
                    Text(["Minimum", "Exact", "Maximum"][aggregateInput.inputInts[30]])
                        .foregroundColor(.secondary)
                }
            }
        }
        .onAppear {
            aggregateInput.inputBools[31] = allowOtherLetters
        }
    }
}

struct CharacterQuantitiesSettingsDetailView: View {
    
    
    var tool: Tool
    
    @ObservedObject var aggregateInput: AggregateInput
    @Environment(\.dismiss) var dismiss
    @AppStorage("quantityMode") private var quantityMode = 0
    
    let labels = ["Minimum", "Exact", "Maximum"]
    
    var body: some View {
        Form {
            Section(
                footer: Text("Choose whether words must contain these letters in at least these quantities (minimum mode), exactly these quantities (exact mode) or at most these quantities (maximum mode).")
            ) {
                ForEach([0,1,2], id: \.self) { i in
                    HStack {
                        Text(labels[i])
                        Spacer()
                        if (aggregateInput.inputInts[30] == i) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                                .font(.body.weight(.medium))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        quantityMode = i
                        aggregateInput.inputInts[30] = i
                        dismiss()
                    }
                }
            }
        }
        .navigationBarTitle("Quantity Mode")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct CharacterQuantitiesResultsView: View {
    
    var aggregateInput: AggregateInput
    
    var body: some View {
        DetailsPair(parameter: "Quantity Mode", value: ["Minimum", "Exact", "Maximum"][aggregateInput.inputInts[30]])
        DetailsPair(parameter: "Allow Other Letters", value: aggregateInput.inputBools[31] ? "Yes" : "No")
    }
}

struct CharacterQuantitiesView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ToolView(tool: Tool.containsQuantitiesTool, selectedSorting: Sorting.allSortings[0], selectedResultDetailType: ResultDetailType.allResultDetailTypes[0])
        }
    }
}
