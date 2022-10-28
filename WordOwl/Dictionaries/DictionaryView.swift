//
//  DictionaryView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 30/01/2022.
//

import SwiftUI

struct DictionaryView: View {
        
    var dictionary: Dictionary
        
    private let maxLength = 200
    
    var body: some View {
        Form {
            Section(header: Text("Dictionary Details")) {
                DetailsPair(parameter: "Name", value: dictionary.name)
                DetailsPair(parameter: "Words", value: "\(dictionary.words.count)")                
            }
            
            Section(header: Text("Dictionary Contents"), footer: Text(dictionary.words.count > maxLength ? "Further words in this large dictionary have not been displayed." : "").padding(.top)) {
                ForEach(dictionary.words.prefix(maxLength), id: \.self) {word in
                    Text(word.capitalizingFirstLetter())
                }
                if dictionary.words.count > maxLength {
                    Text("...")
                        .foregroundColor(.secondary)
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
