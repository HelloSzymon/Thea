//
//  BatchListContentView.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/04/2026.
//

import SwiftUI

struct BatchListContentView: View {
    @ObservedObject var vm: BatchViewModel
    var sortedBatches: [Batch]
    var body: some View {
        List {

            ForEach(sortedBatches) { batch in

                NavigationLink {
                    BatchDetailView(
                        vm: vm, batch: Binding(
                            get: {
                                vm.batchData.first(where: { $0.id == batch.id })!
                            },
                            set: { updated in
                                if let index = vm.batchData.firstIndex(where: { $0.id == updated.id }) {
                                    vm.batchData[index] = updated
                                }
                            }
                        )
                    )
                } label: {
                            BatchRowView(batch: batch)
                        }
            .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                Button(role: .destructive) {
                    if let index = vm.batchData.firstIndex(where: {$0.id == batch.id}){
                        vm.batchData.remove(at: index)}

                } label: {
                    Label("Delete", systemImage: "trash")
                }

                Button(role: .confirm) {
                    if let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) {

                                        vm.batchData[index].status = .finished

                                    }
                } label: {
                    Label("Mark as finished", systemImage: "flag")
                }
            }) }}
    }
}


