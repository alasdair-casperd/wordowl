//
//  CompoundSearchRowView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 19/06/2022.
//

import SwiftUI

struct CompoundSearchRowView: View {
    
    var order: Int
    var tool: Tool
    var aggregateInput: AggregateInput
    var inverted: Bool
    
    var text: String {
        return styledAggregateInputForFilterDisplay(aggregateInput, tool: tool, inverted: inverted)
    }
    
    var initiateEdit: () -> ()
    
    var body: some View {
        HStack(spacing: 0) {
            Text("\(order)")
                .foregroundColor(.accentColor)
                .foregroundColor(.accentColor)
                .padding(.trailing)
            
            VStack(alignment: .leading) {
                Text(tool.name.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)                
                Text(text)
            }
            
            Spacer()
            
            Button(action: initiateEdit) {
                Image(systemName: "square.and.pencil")
            }
        }
        .padding(4)
    }
}

