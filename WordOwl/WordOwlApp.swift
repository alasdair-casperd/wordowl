//
//  WordOwlApp.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/01/2022.
//

import SwiftUI

@main
struct WordOwlApp: App {
    
    static let currentAppVersion = 3
    
    var body: some Scene {
        WindowGroup {
            if UIDevice.current.userInterfaceIdiom == .pad {
                iPadContentView()
            }
            else {
                ContentView()
            }
//                .statusBar(hidden: true)
        }
    }
}
