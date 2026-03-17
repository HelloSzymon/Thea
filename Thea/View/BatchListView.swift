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
            List(batchData) { batch in
                    NavigationLink(destination: BatchDetailView(batch: batch), label:                     {
                BatchRowView(batch: batch)})}

        }
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

#Preview {
    NavigationStack{
        BatchListView()
    }}
