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
