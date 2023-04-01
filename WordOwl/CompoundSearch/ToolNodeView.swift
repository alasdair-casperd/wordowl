//
//  ToolNodeView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 16/02/2022.
//

import SwiftUI

struct ToolNodeView: View {
    
    var tool: Tool
    
    var body: some View {
        HStack {
            VStack(alignment: .leading) {
                Text(tool.shortName.uppercased())
                    .font(.caption)
                    .foregroundColor(.secondary)
                Text("Ends with ") + Text("ing").font(.system(.body, design: .monospaced))
            }
            Spacer()
            Button("Edit") {}
        }
        .padding()
        .background(RoundedRectangle(cornerRadius: 14)
                        .foregroundColor(.white))
    }
}

struct ToolNodeView_Previews: PreviewProvider {
    static var previews: some View {
        ZStack {
            Color.secondary
            ToolNodeView(tool: Tool.endingStringTool)
        }
    }
}
