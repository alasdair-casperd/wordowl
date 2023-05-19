//
//  ContentView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//
import SwiftUI

struct ContentView: View {
        
    @State private var showingWelcomeView = false
    @State private var showingUpdateView = false        
    
    @State private var showingDictionaryTab = UserDefaults.standard.bool(forKey: "showingDictionaryTab")
    
    func updateDictionaryTabVisibility(_ input: Bool) {
        showingDictionaryTab = input
    }
    
    var body: some View {
        TabView {
            ToolsView()
                .tabItem {
                    Label("Search", systemImage: ToolsView.icon)
                }
            
            NavigationView {
                CompoundSearchView()
            }
                .tabItem {
                    Label("Compound", systemImage: CompoundSearchView.filledIcon)
                }
            
            if showingDictionaryTab {
                MainDictionaryView()
                    .tabItem {
                        Label("Dictionary", systemImage: "book.closed.fill")
                    }
            }
            
            HelpView()
                .tabItem {
                    Label("User Guide", systemImage: HelpView.filledIcon)
                }
            
            SettingsView(showWelcomeScreen: {showingWelcomeView = true}, showUpdateScreen: {showingUpdateView = true}, updateDictionaryTabVisibility: updateDictionaryTabVisibility)
                .tabItem {
                    Label("Settings", systemImage: SettingsView.icon)
                }
        }
        .navigationViewStyle(StackNavigationViewStyle())
        .fullScreenCover(isPresented: $showingWelcomeView) {
            GreetingView(greeting: Greeting.welcomeToWordOwl)
        }
        .fullScreenCover(isPresented: $showingUpdateView) {
            GreetingView(greeting: Greeting.updateGreeting(WordOwlApp.currentAppVersion))
        }
        .onAppear {
            
            let seenBefore = UserDefaults.standard.bool(forKey: "Used-Before")
            UserDefaults.standard.set(true, forKey: "Used-Before")
                        
            let lastVersion = UserDefaults.standard.integer(forKey: "app-version")
            UserDefaults.standard.set(WordOwlApp.currentAppVersion, forKey: "app-version")
            
            if !seenBefore {
                showingWelcomeView = true
                showingUpdateView = false
            }
            else {
                showingWelcomeView = false
                if lastVersion < WordOwlApp.currentAppVersion {
                    showingUpdateView = true
                }
                else {
                    showingUpdateView = false
                }
            }
            
        }
    }    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
