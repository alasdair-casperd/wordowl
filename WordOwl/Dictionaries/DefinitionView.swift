//
//  DefinitionView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 16/05/2023.
//

import SwiftUI

struct DefinitionView: UIViewControllerRepresentable {
    @Binding var word: String

    func makeUIViewController(context: UIViewControllerRepresentableContext<DefinitionView>) -> UIReferenceLibraryViewController {
        return UIReferenceLibraryViewController(term: word)
    }

    func updateUIViewController(_ uiViewController: UIReferenceLibraryViewController, context: UIViewControllerRepresentableContext<DefinitionView>) {}
}
