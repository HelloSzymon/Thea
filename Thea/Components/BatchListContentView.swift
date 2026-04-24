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

    private func binding(for batch: Batch) -> Binding<Batch>? {
        guard let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) else {
            return nil
        }

        return Binding(
            get: { vm.batchData[index] },
            set: { vm.batchData[index] = $0 }
        )
    }

    var body: some View {
        List {
            ForEach(sortedBatches) { batch in
                if let batchBinding = binding(for: batch) {
                    NavigationLink {
                        BatchDetailView(vm: vm, batch: batchBinding)
                    } label: {
                        BatchRowView(batch: batch)
                    }
                    .buttonStyle(.plain)
                    .navigationLinkIndicatorVisibility(.hidden)
                    .listRowInsets(EdgeInsets(top: 8, leading: 16, bottom: 8, trailing: 16))
                    .listRowBackground(Color.clear)
                    .listRowSeparator(.hidden)
                    .swipeActions(edge: .trailing, allowsFullSwipe: false) {
                        Button(role: .destructive) {
                            if let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) {
                                vm.batchData.remove(at: index)
                            }
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }

                        Button {
                            if let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) {
                                vm.batchData[index].status = .finished
                            }
                        } label: {
                            Label("Mark as finished", systemImage: "flag")
                        }
                    }
                }
            }
        }
        .listStyle(.plain)
    }
}
