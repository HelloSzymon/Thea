//
//  BatchListView.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/03/2026.
//

import SwiftUI

struct BatchListView: View {
   @State var batchData : [Batch] =  BatchPreview.samples
    @State private var isAddBatchViewSheet: Bool = false
    @State var sortOption : BatchSortOption = .largestVolume

    private var sortedBatches: [Batch] {
        switch sortOption {
        case .largestVolume:
            return batchData.sorted(by: { $0.volume > $1.volume })
        case .newest:
            return batchData.sorted(by: { $0.startDate > $1.startDate })
        case .longestFermenting:
            return batchData.sorted(by: { $0.daysFermenting < $1.daysFermenting })
        }
    }
    var body: some View {
        NavigationStack{
            List {
                ForEach(batchData.indices, id: \.self) { index in
                    let batch = batchData[index]
                NavigationLink(destination: BatchDetailView(batch: batch), label:                     {
                    BatchRowView(batch: batch)})


                .swipeActions(edge: .trailing, allowsFullSwipe: false, content: {
                    Button(role: .destructive) {
                        batchData.remove(at: index)
                    } label: {
                        Label("Delete", systemImage: "trash")
                    }

                    Button(role: .confirm) {
                        batchData[index].status = .finished
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
                batchData.append(newBatch)
            })

        }
        }
    }
}

#Preview {
    NavigationStack{
        BatchListView()
    }}
