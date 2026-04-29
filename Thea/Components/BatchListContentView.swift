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
    @State private var batchToDelete: Batch?
    @State private var recentlyDeletedBatch: Batch?
    @State private var showUndoAlert = false

    private func binding(for batch: Batch) -> Binding<Batch>? {
        guard let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) else {
            return nil
        }

        return Binding(
            get: { vm.batchData[index] },
            set: { vm.batchData[index] = $0 }
        )
    }

    private func primaryAction(for batch: Batch) -> (title: String, icon: String, nextStatus: BatchStatus)? {
        switch batch.status {
        case .fermenting where batch.isReady:
            return ("Mark as bottled", "takeoutbag.and.cup.and.straw", .bottled)
        case .bottled:
            return ("Mark as finished", "flag", .finished)
        default:
            return nil
        }
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
                        if let action = primaryAction(for: batch) {
                            Button {
                                if let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) {
                                    vm.batchData[index].status = action.nextStatus
                                }
                            } label: {
                                Label(action.title, systemImage: action.icon)
                            }
                        }

                        Button(role: .destructive) {
                            batchToDelete = batch
                        } label: {
                            Label("Delete", systemImage: "trash")
                        }

                    }
                }
            }
        }
        .listStyle(.plain)
        .confirmationDialog(
            "Delete batch?",
            isPresented: Binding(
                get: { batchToDelete != nil },
                set: { if !$0 { batchToDelete = nil } }
            ),
            titleVisibility: .visible
        ) {
            Button("Delete", role: .destructive) {
                if let batch = batchToDelete,
                   let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) {
                    recentlyDeletedBatch = batch
                    vm.batchData.remove(at: index)
                    showUndoAlert = true
                }
                batchToDelete = nil
            }
            Button("Cancel", role: .cancel) {
                batchToDelete = nil
            }
        }
        .alert("Batch removed", isPresented: $showUndoAlert) {
            Button("Undo") {
                if let deletedBatch = recentlyDeletedBatch,
                   !vm.batchData.contains(where: { $0.id == deletedBatch.id }) {
                    vm.batchData.append(deletedBatch)
                }
                recentlyDeletedBatch = nil
            }
            Button("OK", role: .cancel) {
                recentlyDeletedBatch = nil
            }
        } message: {
            Text("You can undo this action now.")
        }
    }
}
