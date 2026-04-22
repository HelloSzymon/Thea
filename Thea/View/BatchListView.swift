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
    @State var searchText = ""
    @State private var debouncedSearchText = ""
    @State private var searchWorkItem: DispatchWorkItem?

    private var filteredBatches: [Batch] {
        vm.batchData.filter { batch in

            let matchesSearch =
            debouncedSearchText.isEmpty ||
                batch.name.localizedCaseInsensitiveContains(debouncedSearchText)

            let matchesStatus =
                selectedStatus == nil ||
                batch.status == selectedStatus

            return matchesSearch && matchesStatus
        }
    }
    private var sortedBatches: [Batch] {
        switch sortOption {
        case .largestVolume:
            return filteredBatches.sorted { $0.volume > $1.volume }
        case .newest:
            return filteredBatches.sorted { $0.startDate > $1.startDate }
        case .longestFermenting:
            return filteredBatches.sorted { $0.daysFermenting < $1.daysFermenting }
        }
    }

    @State private var selectedStatus: BatchStatus?

    var body: some View {
            if vm.batchData.isEmpty {
                EmptyStateView{
                    isAddBatchViewSheet.toggle()
                }
          }
            else if sortedBatches.isEmpty {
                NoResultsView()

            }

else {
    BatchListContentView(vm: vm, sortedBatches: sortedBatches)

.searchable(text: $searchText)
.onChange(of: searchText) {
    searchWorkItem?.cancel()
    let task = DispatchWorkItem {
        debouncedSearchText = searchText
    }
    searchWorkItem = task
    DispatchQueue.main.asyncAfter(deadline: .now() + 0.4, execute: task)
}


.sheet(isPresented: $isAddBatchViewSheet) {
   AddBatchView(onSave: { newBatch in
       vm.batchData.append(newBatch)
   })

}
.toolbar {
   BatchToolbarView(selectedStatus: $selectedStatus) {
       isAddBatchViewSheet.toggle()
   }
}

}
            

    }
}


#Preview {
    BatchListView()
}

