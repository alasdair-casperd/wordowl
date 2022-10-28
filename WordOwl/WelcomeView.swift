//
//  WelcomeView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 23/06/2022.
//

import SwiftUI

struct WelcomeView: View {
    var body: some View {
        VStack {
            Text("Welcome to")
            Text("WordOwl")
                .font(.title.weight(.bold))
            
            VStack {
                WelcomeRowView(symbolName: "magnifyingglass", title: "Search for Words", text: "WordOwl contains every tool you could ever need to find exactly the words you're looking for.")
                
                WelcomeRowView(symbolName: "books.vertical.fill", title: "Manage Dictionaries", text: "WordOwl contains every tool you could ever need to find exactly the words you're looking for.")
                
                WelcomeRowView(symbolName: "magnifyingglass", title: "Search for Words", text: "WordOwl contains every tool you could ever need to find exactly the words you're looking for.")
            }
        }
    }
}

struct WelcomeView_Previews: PreviewProvider {
    static var previews: some View {
        WelcomeView()
    }
}

struct WelcomeRowView: View {
    
    let symbolName: String
    let title: String
    let text: String
    
    var body: some View {
        HStack {
            Image(systemName: symbolName)
                .foregroundColor(.accentColor)
                .font(.title)
                .padding()
            VStack(alignment: .leading) {
                Text(title)
                    .font(.body.weight(.bold))
                Text(text)
                    .foregroundColor(.secondary)
            }
            Spacer()
        }
    }
}
