//
//  SettingsView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//

import SwiftUI

struct SettingsView: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    static let simpleIconsKey = "simpleIcons"
    static let icon = "gearshape"
    
    let  exportStylings = ["aa", "Aa", "AA"]
    
    @AppStorage("selectedExportStyling") private var selectedExportStyling = "Aa"
    @AppStorage("addNewLines") private var addNewLines = true
    @AppStorage("selectedSorting") private var selectedSorting = 0
    @AppStorage("selectedResultDetailType") private var selectedResultDetailType = 0
    @AppStorage("hideHelpButtons") private var hideHelpButtons = false
    @AppStorage(simpleIconsKey) private var simpleIcons = false
    @AppStorage(HapticsController.settingString) private var hapticsDisabled = false
    @AppStorage("showingDictionaryTab") private var showingDictionaryTab = false
    
    @State var showingAlert = false
    
    var showWelcomeScreen: () -> ()
    var showUpdateScreen: () -> ()
    var updateDictionaryTabVisibility: (Bool) -> ()
    
    var body: some View {
        NavigationView {
            Form {
                Section(header: Text(iPadVersion ? "Dictionary View" : "Dictionary Tab")) {
                    Toggle(iPadVersion ? "Show Dictionary View" : "Show Dictionary Tab", isOn: $showingDictionaryTab.animation())
                        .onChange(of: showingDictionaryTab) { newValue in
                            updateDictionaryTabVisibility(newValue)
                        }
                        .icon("book.closed")
                }
                
                Section(header: Text("Defaults")) {
                    Picker("Default Ordering", selection: $selectedSorting) {
                        ForEach(0...(Sorting.allSortings.count-1), id: \.self) {i in
                            Text(Sorting.allSortings[i].name).tag(i)
                        }
                        //.navigationBarTitle("Default Ordering")
                        //.navigationBarTitleDisplayMode(.inline)
                    }
                    .icon("list.number")
                    Picker("Default Detail", selection: $selectedResultDetailType) {
                        ForEach(0...(ResultDetailType.allResultDetailTypes.count-1), id: \.self) {i in
                            Text(ResultDetailType.allResultDetailTypes[i].name).tag(i)
                        }
                        //.navigationBarTitle("Default Ordering")
                        //.navigationBarTitleDisplayMode(.inline)
                    }
                    .icon("info.circle")
                }
                
                Section(header: Text("Export")) {
                    HStack {
                        Text("Export Styling")
                            .accessibilityLabel("Export styling: The options are 1. Lowercase, 2. Capitalised or 3. Uppercase")
                        Spacer()
                        Picker("Export Styling", selection: $selectedExportStyling) {
                            ForEach(exportStylings, id: \.self) {
                                Text($0)
                            }
                        }
                        .frame(width: 150)
                        .pickerStyle(SegmentedPickerStyle())
                    }
                    .icon("paintbrush")
                    Toggle("Use Multiple Lines", isOn: $addNewLines)
                        .icon("arrow.up.and.down.text.horizontal")
                }
                Section(header: Text("Input")) {
                    NavigationLink(destination: SingleCharacterInputSettingsView()) {
                        Text("Character Input")
                            .icon("textformat")
                    }
                    NavigationLink(destination: SpacesInputSettingsView()) {
                        Text("Crossword Solver Input")
                            .icon("newspaper")
                    }
                }
                
                Section {
                    if !iPadVersion {
                        Toggle("Reduce Colours", isOn: $simpleIcons)
                            .icon("paintpalette")
                    }
                    Toggle("Hide Help Buttons", isOn: $hideHelpButtons)
                        .icon(hideHelpButtons ? "circle.slash" : "questionmark.circle")
                    if !iPadVersion {
                        Toggle("Disable Haptics", isOn: $hapticsDisabled.animation())
                            .icon("hand.tap")
                    }
                } header: { Text("Customisation") } footer: {
                    if hapticsDisabled {
                        Text("Some in-app haptics will be disabled. The rest are controlled through your device's settings.")
                    }
                }
                
//                Section(header: Text("Debug")) {
//                    NavigationLink("Test Asynchronous Search") {
//                        AsynchronousSearchTestView2()
//                    }
//                    Button("Test Console") {print("Testing console.")}
//                }
                
                if !iPadVersion {
                    Section(footer: MadeWithHeartView()) {
                        Button("Show Welcome Screen") {
                            showWelcomeScreen()
                        }
                        .icon("hand.wave")
                        
                        Button("What's New in this Update?") {
                            showUpdateScreen()
                        }
                        .icon("sparkles")
                        
                        Button("Reset Settings to Defaults") { showingAlert = true }
                            .icon("arrow.counterclockwise")
    //                    Button("Submit feedback") {}
                    }
                }
            }
            .alert("Reset App Settings?", isPresented: $showingAlert) {
                Button("Reset", role: .destructive) { resetSettings() }
                Button("Cancel", role: .cancel) { }
            }
            .navigationTitle("Settings")
            .toolbar {
                ToolbarItem() {
                    if iPadVersion {
                        Button("Done") {
                            presentationMode.wrappedValue.dismiss()
                        }
                    }
                }
                ToolbarItem(placement: .navigationBarLeading) {
                    if iPadVersion {
                        Button("Reset") {
                            showingAlert = true
                        }
                    }
                }
            }
        }
    }
    
    func resetSettings() {
        selectedExportStyling = "Aa"
        addNewLines = true
        selectedSorting = 0
        selectedResultDetailType = 0
        simpleIcons = false
        hapticsDisabled = false
        showingDictionaryTab = false
        hideHelpButtons = false
        UserDefaults.standard.set(true, forKey: "wheelCharacterInput")
        UserDefaults.standard.set(true, forKey: "visualInput")
    }
}

struct SettingsView_Previews: PreviewProvider {
    static var previews: some View {
        SettingsView(showWelcomeScreen: {}, showUpdateScreen: {}, updateDictionaryTabVisibility: {_ in })
            .navigationViewStyle(.stack)
    }
}

// Settings:

// - Which type of picker to use for character input
// - Which type of picker to use for crossword input
// - Reverse sort by anagram / words with friends
// - Choose default additional detail
// - Choose default sortings

// Function:

// - Give feedback
// - Reset application data

struct MadeWithHeartView: View {
    var body: some View {
        HStack {
            Spacer()
            Text("Made with ") + Text("\u{2665}").foregroundColor(.red) + Text(" by Alasdair Casperd")
            Spacer()
        }        
        .padding(.vertical, 28)
    }
}

struct SingleCharacterInputSettingsView: View {
    
    @AppStorage("wheelCharacterInput") private var wheelCharacterInput = true
    
    var body: some View {
        
        Form {
            Section(footer: Text("Use a spinning wheel to select characters when tools require a single character as input.")) {
                Toggle("Wheel Input", isOn: $wheelCharacterInput)
            }
        }
        .navigationTitle("Character Input")
        .navigationBarTitleDisplayMode(.inline)
    }
}

struct SpacesInputSettingsView: View {
    
    @AppStorage("visualInput") private var visualInput = true
    
    var body: some View {
        
        Form {
            Section(footer: Text("Display the input field of the Crossword Solver tool as a series of spaces for shorter word lengths.")) {
                Toggle("Visual Input", isOn: $visualInput)
            }
        }
        .navigationTitle("Visual Input")
        .navigationBarTitleDisplayMode(.inline)
        .onAppear {
            print(visualInput)
            print(UserDefaults.standard.bool(forKey: "visualInput"))
        }
    }
}


/*
 
 //
 //  SettingsView.swift
 //  WordOwl
 //
 //  Created by Alasdair Casperd on 17/01/2022.
 //

 import SwiftUI

 struct SettingsView: View {
     
     private var exportStylings = ["aa", "Aa", "AA"]
     
     @State private var selectedExportStyling = UserDefaults.standard.object(forKey: "selectedExportStyling") == nil ?
         "Aa" : UserDefaults.standard.string(forKey: "selectedExportStyling")
     
     @State private var addNewLines = UserDefaults.standard.object(forKey: "addNewLines") == nil ?
         true : UserDefaults.standard.bool(forKey: "addNewLines")
     
     @State private var selectedSorting = UserDefaults.standard.object(forKey: "selectedSorting") == nil ?
         0 : UserDefaults.standard.integer(forKey: "selectedSorting")
     
     @State private var selectedResultDetailType = UserDefaults.standard.object(forKey: "selectedResultDetailType") == nil ?
         0 : UserDefaults.standard.integer(forKey: "selectedResultDetailType")

     @State private var showingAlert = false
     
     var body: some View {
         NavigationView {
             Form {
                 Section(header: Text("Defaults")) {
                     Picker("Default Ordering", selection: $selectedSorting) {
                         ForEach(0...(Sortings.list.count-1), id: \.self) {i in
                             Text(Sortings.list[i].name).tag(i)
                         }
                         //.navigationBarTitle("Default Ordering")
                         //.navigationBarTitleDisplayMode(.inline)
                     }
                     .onChange(of: selectedSorting) { newValue in
                           UserDefaults.standard.set(newValue, forKey: "selectedSorting")
                     }
                     Picker("Default Detail", selection: $selectedResultDetailType) {
                         ForEach(0...(ResultDetailTypes.list.count-1), id: \.self) {i in
                             Text(ResultDetailTypes.list[i].name).tag(i)
                         }
                         //.navigationBarTitle("Default Ordering")
                         //.navigationBarTitleDisplayMode(.inline)
                     }
                     .onChange(of: selectedResultDetailType) { newValue in
                           UserDefaults.standard.set(newValue, forKey: "selectedResultDetailType")
                     }
                 }
                 Section(header: Text("Export")) {
                     HStack {
                         Text("Export Styling")
                         Spacer()
                         Picker("Export Styling", selection: $selectedExportStyling) {
                             ForEach(exportStylings, id: \.self) {
                                 Text($0)
                             }
                         }
                         .frame(width: 150)
                         .pickerStyle(SegmentedPickerStyle())
                     }
                     Toggle("Use Multiple Lines", isOn: $addNewLines)
                     .onChange(of: addNewLines, perform: { newValue in
                         UserDefaults.standard.set(newValue, forKey: "addNewLines")
                     })
                 }
                 Section(header: Text("Input")) {
                     NavigationLink(destination: SingleCharacterInputSettingsView()) {
                         Text("Character Input")
                     }
                     NavigationLink(destination: SpacesInputSettingsView()) {
                         Text("Crossword Solver Input")
                     }
                 }
                 Section(footer: MadeWithHeartView()) {
                     Button("Reset Settings to Defaults") { showingAlert = true }
                     .alert("Reset App Settings?", isPresented: $showingAlert) {
                         Button("Reset", role: .destructive) { resetSettings() }
                         Button("Cancel", role: .cancel) { }
                     }
                     Button("Submit feedback") {}
                 }
             }
             .navigationTitle("Settings")
         }
     }
     
     func resetSettings() {
         selectedExportStyling = "Aa"
         addNewLines = true
         selectedSorting = 0
         selectedResultDetailType = 0
     }
 }

 struct SettingsView_Previews: PreviewProvider {
     static var previews: some View {
         SettingsView()
     }
 }

 // Settings:

 // - Which type of picker to use for character input
 // - Which type of picker to use for crossword input
 // - Reverse sort by anagram / words with friends
 // - Choose default additional detail
 // - Choose default sortings

 // Function:

 // - Give feedback
 // - Reset application data

 struct MadeWithHeartView: View {
     var body: some View {
         HStack {
             Spacer()
             Text("Made with ") + Text("\u{2665}").foregroundColor(.red) + Text(" by Alasdair Casperd")
             Spacer()
         }
         .padding(.top)
     }
 }

 struct SingleCharacterInputSettingsView: View {
     
     @AppStorage("wheelCharacterInput") private var wheelCharacterInput = true
     
     var body: some View {
         
         Form {
             Section(footer: Text("Use a spinning wheel to select characters when tools require a single character as input.")) {
                 Toggle("Wheel Input", isOn: $wheelCharacterInput)
             }
         }
         .navigationTitle("Character Input")
         .navigationBarTitleDisplayMode(.inline)
     }
 }

 struct SpacesInputSettingsView: View {
     
     @AppStorage("visualInput") private var visualInput = true
     
     var body: some View {
         
         Form {
             Section(footer: Text("Display the input field of the Crossword Solver tool as a series of spaces.")) {
                 Toggle("Visual Input", isOn: $visualInput)
             }
         }
         .navigationTitle("Visual Input")
         .navigationBarTitleDisplayMode(.inline)
     }
 }

 */
