//
//  SettingsView.swift
//  Thea
//
//  Created by Szymon Wnuk on 04/03/2026.
//

import SwiftUI

struct SettingsView: View {
    @AppStorage("defaultFermentationDays")
    private var defaultFermentationDays: Int = 7
    var body: some View {
        NavigationStack {
            Form{
                Section("Fermentation"){
                    Stepper("Default days \(defaultFermentationDays)", value: $defaultFermentationDays, in: 1...30)
                        .padding()
                }
            }



                .navigationTitle("Settings")
        }
    }
}

#Preview {
    SettingsView()
}
