//
//  BatchToolbarView.swift
//  Thea
//
//  Created by Szymon Wnuk on 07/04/2026.
//

import SwiftUI

struct BatchToolbarView: ToolbarContent {
    @Binding var selectedStatus: BatchStatus?
    var onAddTap: () -> Void

    var body: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            Button{
               onAddTap()
            } label: {
                Image(systemName: "plus")
            }
        }
        ToolbarItem(placement: .title) {
            Picker("Status", selection: $selectedStatus) {
                Text("All").tag(BatchStatus?.none)
                Text("Bottled").tag(Optional(BatchStatus.bottled))
                Text("Fermenting").tag(Optional(BatchStatus.fermenting))
                Text("Finished").tag(Optional(BatchStatus.finished))
            }
            .pickerStyle(.palette)
        }
    }
}
