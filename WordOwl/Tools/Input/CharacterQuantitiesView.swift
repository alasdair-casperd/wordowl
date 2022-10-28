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
    
    var body: some View {
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
        NavigationLink(destination: MultipleCharactersDetailView(tool: Tools.containsOnlyTool, aggregateInput: aggregateInput)) {
            Text(listNonEmpty() ? "Select Characters" : "Add Characters")
        }
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
    
    var body: some View {
        Section(header: Text("Tool Settings")) {
            Toggle("Allow Other Letters", isOn: $aggregateInput.inputBools[31])
            NavigationLink(destination: CharacterQuantitiesSettingsDetailView(tool: tool, aggregateInput: aggregateInput)) {
                HStack {
                    Text("Quantity Mode")
                    Spacer()
                    Text(["Minimum", "Exact", "Maximum"][aggregateInput.inputInts[30]])
                        .foregroundColor(.secondary)
                }
            }
        }
    }
}

struct CharacterQuantitiesSettingsDetailView: View {
    
    
    var tool: Tool
    
    @ObservedObject var aggregateInput: AggregateInput
    @Environment(\.dismiss) var dismiss
    
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
