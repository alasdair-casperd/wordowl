//
//  CharacterQuantitiesInputView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 07/02/2022.
//

import SwiftUI

struct CharacterQuantitiesInputView: View {
    var body: some View {
        HStack {
            Text(/*@START_MENU_TOKEN@*/"Hello, World!"/*@END_MENU_TOKEN@*/)
            Spacer()            
        }
        Button("Add Character") {}
    }
}

struct CharacterQuantitiesInputView_Previews: PreviewProvider {
    static var previews: some View {
        Form {
            CharacterQuantitiesInputView()
        }
    }
}
