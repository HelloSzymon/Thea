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
        if searchText.isEmpty {
            return vm.batchData
        } else {
            return vm.batchData.filter{  $0.name.localizedCaseInsensitiveContains(searchText)}
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

    var body: some View {
        NavigationStack{
            if !vm.batchData.isEmpty {
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
        }
        .searchable(text: $searchText)

            }
            
else {
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

