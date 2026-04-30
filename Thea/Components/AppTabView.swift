//
//  Tabview.swift
//  Thea
//
//  Created by Szymon Wnuk on 30/04/2026.
//

import SwiftUI

struct AppTabView: View {
    @StateObject private var vm = BatchViewModel()

    var body: some View {
        TabView{
            Tab("Batches", systemImage: "list.bullet") {
                NavigationStack {
                    BatchListView(vm: vm)
                }
            }
            Tab("Analitycs", systemImage: "chart.bar") {
                NavigationStack {
                    AnalitycsView(batches: vm.batchData)
                        .navigationTitle("Analytics")
                }
            }
            Tab("Settings", systemImage: "gearshape") {
                SettingsView()
            }
        }
    }
}

#Preview {
    AppTabView()
}
