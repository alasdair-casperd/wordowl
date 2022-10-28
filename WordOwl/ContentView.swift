//
//  ContentView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//
import SwiftUI

struct ContentView: View {
    
    var body: some View {
        TabView {
            ToolsView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }

//            DictionariesView()
//                .tabItem {
//                    Label("Dictionaries", systemImage: "books.vertical.fill")
//                }
            
            CompoundSearchView()
                .tabItem {
                    Label("Compound", systemImage: "slider.horizontal.3")
                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }        
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
