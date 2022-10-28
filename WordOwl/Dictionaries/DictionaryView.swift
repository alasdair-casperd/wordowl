//
//  DictionaryView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/01/2022.
//

import SwiftUI

struct DictionaryView: View {
        
    var dictionary: Dictionary
        
    var body: some View {
        Form {
            Section(header: Text("Dictionary Details")) {
                DetailsPair(parameter: "Name", value: dictionary.name)
                DetailsPair(parameter: "Words", value: "\(dictionary.words.count)")
            }
            
            Section(header: Text("Dictionary Contents")) {
                ForEach(dictionary.words, id: \.self) {word in
                    Text(word.capitalizingFirstLetter())
                }
            }
        }
        .navigationTitle(dictionary.titleName)
    }
}

struct DictionaryView_Previews: PreviewProvider {
    static var previews: some View {
        DictionaryView(dictionary: Dictionaries.list[1])
    }
}
