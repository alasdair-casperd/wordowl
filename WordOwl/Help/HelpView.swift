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
    
    @Environment(\.presentationMode) var presentationMode
    
    let columns = [GridItem(.adaptive(minimum: 150), spacing: 14)]
    
    var body: some View {
        NavigationView {
//            Form {
//                Section(header: Text("General")) {
//                    ForEach(Document.generalGuides) { document in
//                        DocumentRowView(document: document)
//                    }
//                }
//                Section(header: Text("Compound Search")) {
//                    ForEach(Document.compoundSearchDocuments) { document in
//                        DocumentRowView(document: document)
//                    }
//                }
//                Section(header: Text("Tools")) {
//                    ForEach(Document.toolGuides) { document in
//                        DocumentRowView(document: document)
//                    }
//                }
//            }
            ScrollView {
                VStack(alignment: .leading) {
                    Text("Welcome to the WordOwl user guide! Browse the pages below for information on our suite of tools and everything else WordOwl has to offer!")
                    Text("General")
                        .font(.title2.weight(.bold))
                        .padding(.vertical)
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(Document.generalGuides) { document in
                            DocumentCellView(document: document)
                        }
                    }
                    Text("Compound Search")
                        .font(.title2.weight(.bold))
                        .padding(.vertical)
                        .padding(.top)
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(Document.compoundSearchDocuments) { document in
                            DocumentCellView(document: document)
                        }
                    }
                    Text("Tools")
                        .font(.title2.weight(.bold))
                        .padding(.vertical)
                        .padding(.top)
                    LazyVGrid(columns: columns, spacing: 14) {
                        ForEach(Document.toolGuides) { document in
                            DocumentCellView(document: document)
                        }
                    }
                }
                .padding(.horizontal)
                .padding(.bottom)
            }
            .background {
                Color.backgroundColor.edgesIgnoringSafeArea(.all)
            }
            .navigationTitle("User Guide")
            .toolbar {
                ToolbarItem() {
                    if iPadVersion {
                        Button("Done") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
            }
        }
    }
}

struct DocumentRowView: View {
    
    var document: Document
    
    var body: some View {
        NavigationLink(destination: DocumentView(document: document).navigationTitle(document.name).navigationBarTitleDisplayMode(.inline)){
            Text(document.name)
                .icon(document.icon)
        }
    }
}

struct DocumentCellView: View {
    
    var document: Document
    
    var body: some View {
        NavigationLink(destination: DocumentView(document: document).navigationTitle(document.name).navigationBarTitleDisplayMode(.inline)){
            VStack(alignment: .leading) {
                Spacer()
                HStack {
                    Text("").icon(document.icon, color: document.tool?.color ?? .accentColor.opacity(0.7), style: .smallBold)
                        .padding(.leading, 4)
                        .padding(.bottom)
//                    Group {
//                        switch document.icon {
//                        case .image(let systemName):
//                            Image(systemName: systemName)
//                        case .character(let text):
//                            Text(text.prefix(1))
//                        }
//                    }
//                    .font(.title)
//                    .frame(width: 50, height: 50, alignment: .leading)
//                    .foregroundColor(.accentColor)
                    Spacer()
                }
                VStack(alignment: .leading, spacing: 4) {
                    Text(document.name)
                        .foregroundColor(.primary)
                        .fontWeight(.bold)
                        .multilineTextAlignment(.leading)
                        .lineLimit(1)
                        .font(.callout)
                    HStack(alignment: .bottom, spacing: 4) {
                        Text(document.description)
                            .lineLimit(3)
                            .multilineTextAlignment(.leading)
                            .font(.caption)
                    }
                    .foregroundColor(.secondary)
                }
            }
            .padding()
            .background(RoundedRectangle(cornerRadius: 14).foregroundColor(.panelColor))
        }
    }
}

struct HelpView_Previews: PreviewProvider {
    static var previews: some View {
        HelpView()
    }
}
