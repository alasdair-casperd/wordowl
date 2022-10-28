//
//  ToolInputView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 06/02/2022.
//

import SwiftUI

struct ToolInputView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        switch tool.input {
        case .character:
            CharacterInputView(tool: tool, aggregateInput: aggregateInput)
        case .string:
            StringInputView(tool: tool, aggregateInput: aggregateInput)
        case .number:
            NumberInputView(tool: tool, aggregateInput: aggregateInput)
        case.range:
            RangeInputView(tool: tool, aggregateInput: aggregateInput)
        case .spaces:
            SpacesInputView(tool: tool, aggregateInput: aggregateInput)
        case .multipleCharacters:
            MultipleCharactersView(tool: tool, aggregateInput: aggregateInput)
        case .characterQuantities:
            CharacterQuantitiesView(tool: tool, aggregateInput: aggregateInput)
        }
    }
}

struct ToolSettingsView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        switch tool.input {
        case .characterQuantities:
            CharacterQuantitiesSettingsView(tool: tool, aggregateInput: aggregateInput)
        default:
            EmptyView()
        }
    }
}

struct ToolResultsDetailsView: View {
    
    var tool: Tool
    @ObservedObject var aggregateInput: AggregateInput
    
    var body: some View {
        switch tool.input {
        case .characterQuantities:
            CharacterQuantitiesResultsView(aggregateInput: aggregateInput)
        default:
            EmptyView()
        }
    }
}
