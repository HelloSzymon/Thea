//
//  SettingsView.swift
//  Thea
//
//  Created by Szymon Wnuk on 04/03/2026.
//

import SwiftUI

enum VolumeUnit: String, CaseIterable {
    case liters
    case gallons
}

struct SettingsView: View {
    @AppStorage("defaultFermentationDays")
    private var defaultFermentationDays: Int = 7
    @AppStorage("volumeUnit")
     private var volumeUnit: String = VolumeUnit.liters.rawValue
    var body: some View {
        NavigationStack {
            Form{
                Section("Fermentation"){
                    Stepper("Default days \(defaultFermentationDays)", value: $defaultFermentationDays, in: 1...30)
                        .padding()
                }

                Picker("Volume unit", selection: $volumeUnit, content: {
                    ForEach(VolumeUnit.allCases, id: \.self) {
                        Text($0.rawValue.capitalized).tag($0.rawValue)
                    }
                }) .padding()
            }



                .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
