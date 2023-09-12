//
//  MultipleCharactersView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 07/02/2022.
//

import SwiftUI

struct MultipleCharactersView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    @State private var inputText = ""    
    @AppStorage("multipleCharactersInputStyle") private var inputSyle = 1
    
    var body: some View {
        Section {
            if inputSyle == 1{
                NavigationLink(destination: MultipleCharactersDetailView(tool: tool, aggregateInput: aggregateInput)) {
                    HStack {
                        Text("Characters")
                        Spacer()
                        Text(aggregateInput.styledFor(tool: tool))
                            .foregroundColor(.secondary)
                    }
                }
                .onDisappear {
                    styleTextForAggregateInput()
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
    }
    
    func styleAggregateInputForString(input: String) {
        for c in EnglishAlphabet.allCases {
            aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: c)!] = input.uppercased().contains(where: {a in return String(a) == c.rawValue})
        }
    }
    
    func styleTextForAggregateInput() {
        var output = ""
        for c in EnglishAlphabet.allCases {
            if (aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: c)!]) {
                output += c.rawValue
            }
        }
        inputText = output
    }
}

struct MultipleCharactersDetailView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        Form {
            Section {
                HStack {
                    Text("Selected Characters")
                    Spacer()
                    Text(aggregateInput.styledFor(tool: tool))
                        .foregroundColor(.secondary)
                }
            }
            Section {
                ForEach(EnglishAlphabet.allCases, id: \.self) { letter in
                    HStack {
                        Text(letter.rawValue)
                        Spacer()
                        if (aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!]) {
                            Image(systemName: "checkmark")
                                .foregroundColor(.accentColor)
                                .font(.body.weight(.medium))
                        }
                    }
                    .contentShape(Rectangle())
                    .onTapGesture {
                        aggregateInput.inputBools[EnglishAlphabet.allCases.firstIndex(of: letter)!].toggle()
                        aggregateInput.inputInts[EnglishAlphabet.allCases.firstIndex(of: letter)!] = 1
                    }
                }
            }
            
            Section {
                Button(action: {dismiss()}) {
                    HStack {
                        Spacer()
                        Text("Done")
                        Spacer()
                    }
                }
            }
        }
        .navigationBarTitle("Characters")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct MultipleCharactersView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ToolView(tool: Tool.containsOnlyTool, selectedSorting: Sorting.allSortings[0], selectedResultDetailType: ResultDetailType.allResultDetailTypes[0])
        }
    }
}

