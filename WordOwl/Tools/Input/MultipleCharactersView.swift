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
    
    var body: some View {
        NavigationLink(destination: MultipleCharactersDetailView(tool: tool, aggregateInput: aggregateInput)) {
            HStack {
                Text("Characters")
                Spacer()
                Text(aggregateInput.styledFor(tool: tool))
                    .foregroundColor(.secondary)
            }
        }
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
