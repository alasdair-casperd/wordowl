//
//  ContentView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//
import SwiftUI

struct ContentView: View {
        
    @State private var showingWelcomeView = false
    
    var body: some View {
        TabView {
            ToolsView()
                .tabItem {
                    Label("Search", systemImage: "magnifyingglass")
                }
            
            CompoundSearchView()
                .tabItem {
                    Label("Compound", systemImage: "slider.horizontal.3")
                }
            
//            DictionariesView()
//                .tabItem {
//                    Label("Dictionaries", systemImage: "books.vertical.fill")
//                }
            
            SettingsView()
                .tabItem {
                    Label("Settings", systemImage: "gearshape")
                }
        }
        .fullScreenCover(isPresented: $showingWelcomeView) {
            WelcomeView()
        }
        .onAppear {
            showingWelcomeView = !UserDefaults.standard.bool(forKey: "Used Before")
            UserDefaults.standard.set(true, forKey: "Used Before")
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
