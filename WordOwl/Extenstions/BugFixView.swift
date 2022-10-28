//
//  BugFixView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 13/02/2022.
//

import SwiftUI

struct BugFixView: View {
    
    @State private var selection = "Apple"
    let fruits = ["Apple", "Banana", "Pear"]
    
    var body: some View {
        NavigationView {
            Form {
                Text("Testing")
                Picker("Choose a fruit", selection: $selection) {
                    ForEach(fruits, id: \.self) { fruit in
                        Text(fruit)
                    }
                    .navigationTitle("Picker Title")
                }
                NavigationLink(destination: Text("Detail View").navigationTitle("Detail View")) {
                    Text("To Detail View")
                }
            }
            .navigationTitle("Form Title")
        }
    }
}

struct BugFixView_Previews: PreviewProvider {
    static var previews: some View {
        BugFixView()
    }
}
