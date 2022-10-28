//
//  AsynchronousSearchTestView.swift
//  WordOwl
//
//  Created by Alasdair Casperd on 17/02/2022.
//

import SwiftUI

struct AsynchronousSearchTestView: View {
    
    @State private var results = [String]()
    @State private var animationAmount = 1.0
    var body: some View {
        Form {
            Section {
                Button("Search for words") {
                    let aggregateInput = AggregateInput()
                    aggregateInput.inputBools[0] = true
                    aggregateInput.inputBools[19] = true
                    aggregateInput.inputBools[14] = true
                    aggregateInput.inputBools[15] = true
                    aggregateInput.inputInts[15] = 2
                    aggregateInput.inputInts[14] = 1
                    aggregateInput.inputInts[0] = 2
                    aggregateInput.inputInts[19] = 1
                    aggregateInput.inputInts[30] = 0
                    aggregateInput.inputBools[31] = true
                    results = containsQuantities(Dictionaries.list[0], aggregateInput)
                }
                .overlay(
                    Circle()
                        .stroke(.red)
                        .scaleEffect(animationAmount)
                        .animation(
                            .easeOut(duration: 1)
                                .repeatForever(autoreverses: true),
                            value: animationAmount
                        )
                )
                .onAppear {
                    animationAmount = 10
                }
                Button("Clear results", role: .destructive) {
                    results = [String]()
                }
            }
            Section {
                ForEach(results, id: \.self) { result in
                    Text(result)
                }
            }
        }
    }
}

struct AsynchronousSearchTestView_Previews: PreviewProvider {
    static var previews: some View {
        AsynchronousSearchTestView()
    }
}
