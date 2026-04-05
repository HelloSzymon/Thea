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

    private var filteredBatches: [Batch] {
        vm.batchData.filter { batch in

            let matchesSearch =
                searchText.isEmpty ||
                batch.name.localizedCaseInsensitiveContains(searchText)

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
        NavigationStack{
            if vm.batchData.isEmpty {
                VStack{
                    Image(systemName: "leaf")
                        .font(.largeTitle)
                    Text("Add your first batch")
                        .fontWeight(.bold)
                    Button{
                        isAddBatchViewSheet.toggle()
                    } label: {
                        HStack{
                            Text("Add batch")

                            Image(systemName: "plus")
                        }

                    }
                }
          }
            else if sortedBatches.isEmpty {
                VStack{

                    Text("No results")
                    .fontWeight(.bold)}
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        Button{
                            isAddBatchViewSheet.toggle()
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

else {
    List {

        ForEach(sortedBatches) { batch in

            NavigationLink {
                if let index = vm.batchData.firstIndex(where: {$0.id == batch.id}) {
                    EditBatchView(

                        batch: $vm.batchData[index],
                    )}
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
.toolbar {
    ToolbarItem(placement: .topBarTrailing) {
        Button{
            isAddBatchViewSheet.toggle()
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
.searchable(text: $searchText)




}
            
        }    .sheet(isPresented: $isAddBatchViewSheet) {
            AddBatchView(onSave: { newBatch in
                vm.batchData.append(newBatch)
            })

        }

    }
}


#Preview {
    BatchListView()
}

