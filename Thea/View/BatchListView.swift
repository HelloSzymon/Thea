//
//  BatchListView.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/03/2026.
//

import SwiftUI

struct BatchListView: View {

    var batchData : [Batch] =  BatchPreview.samples
    @State private var isAddBatchViewSheet: Bool = false
    @State var savedData: Batch
    var body: some View {
        NavigationStack{
            List(batchData) { batch in
                    NavigationLink(destination: BatchDetailView(batch: batch), label:                     {
                        VStack(alignment: .leading){
                    Text(batch.name)
                    Text(batch.status.displayName)
                    Text("Days fermenting: \(batch.daysFermenting)")
                }})}

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
            AddBatchView(savedData: $savedData)
        }
    }
}

#Preview {
    NavigationStack{
        BatchListView(savedData: Batch(name: "", startDate: Date(), volume: 20.0, unit: .gallons, status: .bottled))
    }}
