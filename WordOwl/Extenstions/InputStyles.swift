//
//  InputStyles.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 07/02/2022.
//

import Foundation
import SwiftUI

struct CompactTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .frame(height: 40)
            .background(Color("CompactInputColor"))
            .cornerRadius(8)
    }
}

struct CompactPaddedTextFieldStyle: TextFieldStyle {
    func _body(configuration: TextField<Self._Label>) -> some View {
        configuration
            .padding(.horizontal)
            .frame(height: 40)
            .background(Color("CompactInputColor"))
            .cornerRadius(8)
    }
}
