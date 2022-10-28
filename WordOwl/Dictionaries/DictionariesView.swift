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
                ForEach(Dictionaries.list) { dictionary in
                    NavigationLink(destination: DictionaryView(dictionary: dictionary))
                    {
                        HStack {
                            Image(systemName: dictionary.symbolName ?? "text.book.closed.fill")
                                .foregroundColor(.accentColor)
                                .font(.title2)
                            .frame(width: 35, height: 50, alignment: .center)
                            Text(dictionary.name)
                            Spacer()
                            
                        }
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
