//
//  DetailsPair.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/01/2022.
//

import SwiftUI

struct DetailsPair: View {
    
    var parameter: String
    var value: String
    
    var body: some View {
        HStack {
            Text(parameter)
            Spacer()
            Text(value)
                .foregroundColor(.secondary)
        }
    }
}
