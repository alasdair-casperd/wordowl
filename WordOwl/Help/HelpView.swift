//
//  Help View.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 01/04/2023.
//

import SwiftUI

struct HelpView: View {
    
    static let filledIcon = "book.fill"
    static let icon = "book"
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text("General")) {
                    ForEach(Document.generalGuides) { document in
                        DocumentRowView(document: document)
                    }
                }
                Section(header: Text("Compound Search")) {
                    ForEach(Document.compoundSearchDocuments) { document in
                        DocumentRowView(document: document)
                    }
                }
                Section(header: Text("Tools")) {
                    ForEach(Document.toolGuides) { document in
                        DocumentRowView(document: document)
                    }
                }
            }
            .navigationTitle("User Guide")
        }
    }
}

struct DocumentRowView: View {
    
    var document: Document
    
    var body: some View {
        NavigationLink(destination: DocumentView(document: document)){
            Text(document.name)
                .icon(document.icon)
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
