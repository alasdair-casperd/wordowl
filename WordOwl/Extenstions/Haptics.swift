//
//  Haptics.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 31/03/2023.
//

import SwiftUI

class HapticsController {
    
    static let settingString = "hapticsDisabled"
    
    static func performHaptic(_ style: UIImpactFeedbackGenerator.FeedbackStyle = .rigid) {
        if !UserDefaults.standard.bool(forKey: settingString) {
            let impactMed = UIImpactFeedbackGenerator(style: style)
            impactMed.impactOccurred()
        }
    }
}
