//
//  SwiftUIView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/01/2022.
//

import SwiftUI

struct DictionariesView: View {
    var body: some View {
        NavigationView {
            Form {
                ForEach(Dictionary.mainDictionaries) { dictionary in
                    NavigationLink(destination: DictionaryView(dictionary: dictionary))
                    {
                        VStack(alignment: .leading) {
                            Text(dictionary.name)
                                .font(.headline)
                            Text("\(dictionary.wordCount ?? "?") Words")
                                .foregroundColor(.secondary)
                        }
                        .icon(dictionary.symbolName ?? "book.closed", style: .bold)
                    }                    
                }
            }
            .navigationTitle("Dictionaries")
        }
    }
}

struct SwiftUIView_Previews: PreviewProvider {
    static var previews: some View {
        DictionariesView()
    }
}
