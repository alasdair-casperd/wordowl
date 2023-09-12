//
//  ToolInstructionsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 20/05/2023.
//

import SwiftUI

struct ToolInstructionsView: View {
    var tool: Tool
    var body: some View {
        Text(tool.description)
            .foregroundColor(.primary)
            .font(.body)
            .textCase(.none)
            .listRowInsets(EdgeInsets())
            .padding(.bottom)
    }
}
