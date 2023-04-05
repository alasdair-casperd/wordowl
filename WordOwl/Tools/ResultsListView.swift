//
//  ResultsListView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 31/03/2023.
//

import SwiftUI

struct ResultsListView: View {
    
    var results: [String]
    var resultDetailType: ResultDetailType
    
    var body: some View {
        List {
            if results.count > 0 {
                ForEach(results, id: \.self) { result in
                    HStack {
                        Text(result)
                        Spacer()
                        Text(resultDetailType.detail(result))
                            .foregroundColor(.secondary)
                    }
                }
            }
            else {
                Text("No Results Found")
                    .foregroundColor(.secondary)
            }
        }
        .id(UUID())
        .navigationTitle("Full Results")
        .navigationBarTitleDisplayMode(.large)
    }
}

struct ResultsListView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView {
            ResultsListView(results: [String](), resultDetailType: ResultDetailType.allResultDetailTypes[0])
        }
    }
}
