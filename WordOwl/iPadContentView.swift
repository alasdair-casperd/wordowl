//
//  iPadContentView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 19/05/2023.
//

import SwiftUI

struct iPadContentView: View {
    
    @State private var showingWelcomeView = false
    @State private var showingUpdateView = false
    @State private var showingSettingsView = false
    @State private var showingHelpView = false
    @State private var showingCompoundSearchView = false
    @State private var showingDictionaryTab = UserDefaults.standard.bool(forKey: "showingDictionaryTab")
    
    @State private var selectedTool: Tool? = Tool.anagramsTool
    
    @State private var defaultSorting = Sorting.allSortings[UserDefaults.standard.integer(forKey: "selectedSorting")]
    @State private var defaultResultDetailType = ResultDetailType.allResultDetailTypes[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
    
    func updateDictionaryTabVisibility(_ input: Bool) {
        showingDictionaryTab = input
    }
    
    var body: some View {
        NavigationView{
            List {
                ForEach(Tool.categories) { category in
                    Section {
                        ForEach(category.tools) { tool in
                            NavigationLink(destination: ToolView(tool: tool, selectedSorting: defaultSorting, selectedResultDetailType: defaultResultDetailType), tag: tool, selection: $selectedTool) {
                                ToolRowItem(tool: tool)
                            }
                        }
                    } header: {
                        Text(category.name)
                    }
                }
                
                Section(header: Text("Further Tools")) {
                    NavigationLink(destination: CompoundSearchView()) {
                        Text("Compound Search")
                            .icon(CompoundSearchView.icon, color: Color("WordOwl Warm Blue"), style: .smallBold)
                    }
                    if showingDictionaryTab {
                        NavigationLink(destination: MainDictionaryView()) {
                            Text("Dictionary")
                                .icon("book.closed", color: Color("WordOwl Warm Blue"), style: .smallBold)
                        }
                    }
                }
            }
            .listStyle(SidebarListStyle())
            .navigationTitle("WordOwl")
            .toolbar {
                ToolbarItem() {
                    Button(action: {showingHelpView.toggle()}) {
                        Image(systemName: HelpView.icon)
                    }
                }
                ToolbarItem() {
                    Button(action: {showingSettingsView.toggle()}) {
                        Image(systemName: "gearshape")
                    }
                }
            }
            VStack {
                Spacer()
                Image(systemName: "ipad.landscape")
                    .font(.largeTitle)
                    .foregroundColor(.accentColor)
                HStack {
                    Spacer()
                    Text("To start, select a tool from the sidebar or rotate your device to the landscape orientation.")
                        .multilineTextAlignment(.center)
                        .frame(maxWidth: 380)
                        .padding()
                    Spacer()
                }
                Spacer()
            }
            .foregroundColor(.secondary)
            .background(Color.backgroundColor).edgesIgnoringSafeArea(.all)
        }
        
        
        
        //            CompoundSearchView()
        //                .tabItem {
        //                    Label("Compound", systemImage: CompoundSearchView.filledIcon)
        //                }
        //
        //            if showingDictionaryTab {
        //                MainDictionaryView()
        //                    .tabItem {
        //                        Label("Dictionary", systemImage: "book.closed.fill")
        //                    }
        //            }

        
        .sheet(isPresented: $showingSettingsView) {
            SettingsView(showWelcomeScreen: {showingWelcomeView = true}, showUpdateScreen: {showingUpdateView = true}, updateDictionaryTabVisibility: updateDictionaryTabVisibility)
        }
        .sheet(isPresented: $showingHelpView) {
            HelpView()
        }
        .fullScreenCover(isPresented: $showingCompoundSearchView) {
            CompoundSearchView()
        }
        .sheet(isPresented: $showingWelcomeView) {
            GreetingView(greeting: Greeting.welcomeToWordOwl)
        }
        .fullScreenCover(isPresented: $showingUpdateView) {
            GreetingView(greeting: Greeting.updateGreeting(WordOwlApp.currentAppVersion))
        }
        .onAppear {
            
            defaultSorting = Sorting.allSortings[UserDefaults.standard.integer(forKey: "selectedSorting")]
            defaultResultDetailType = ResultDetailType.allResultDetailTypes[UserDefaults.standard.integer(forKey: "selectedResultDetailType")]
            
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

struct iPadContentView_Previews: PreviewProvider {
    static var previews: some View {
        iPadContentView()
    }
}
