//
//  BatchListView.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/03/2026.
//

import SwiftUI

struct BatchListView: View {
    @StateObject var vm =  BatchViewModel()
    @State private var isAddBatchViewSheet: Bool = false
    @State var sortOption : BatchSortOption = .largestVolume

    private var sortedBatches: [Batch] {
        switch sortOption {
        case .largestVolume:
            return vm.batchData.sorted(by: { $0.volume > $1.volume })
        case .newest:
            return vm.batchData.sorted(by: { $0.startDate > $1.startDate })
        case .longestFermenting:
            return vm.batchData.sorted(by: { $0.daysFermenting < $1.daysFermenting })
        }
    }


    var body: some View {
        NavigationStack{
            List {
                ForEach(vm.batchData.indices, id: \.self) { index in
                    let batch = vm.batchData[index]

                    NavigationLink {
                        EditBatchView(
                            batch: $vm.batchData[index],
                            onSave: {
                                vm.saveBatches(batch: vm.batchData)
                            }
                        )
                    } label: {
                        BatchRowView(batch: batch)
                    }
                .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                    Button(role: .destructive) {
                        if let index = vm.batchData.firstIndex(where: {$0.id == batch.id}){
                            vm.batchData.remove(at: index)}
                            vm.saveBatches(batch: vm.batchData)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                    Button(role: .confirm) {
                        if let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) {

                                            vm.batchData[index].status = .finished
                                            vm.saveBatches(batch: vm.batchData)
                                        }
                    } label: {
                        Label("Mark as finished", systemImage: "flag")
                    }
                }) }}
        .toolbar {
            ToolbarItem(placement: .topBarTrailing) {
                Button{
                    isAddBatchViewSheet.toggle()
                } label: {
                    Image(systemName: "plus")
                }
            }
        }
        .sheet(isPresented: $isAddBatchViewSheet) {
            AddBatchView(onSave: { newBatch in
                vm.batchData.append(newBatch)
            })

        }
        }
        .onAppear{
            vm.batchData = vm.loadBatches()
        }
    }
}


#Preview {
    BatchListView()
}

