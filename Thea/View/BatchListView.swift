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

    func saveBatches(batch: [Batch]) {
        do {
            let data = try JSONEncoder().encode(batch)
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentDirectory.appendingPathComponent("batch.json")
            try data.write(to: fileURL)
        } catch {
            print("Error saving JSON: \(error)")
        }
    }

    func loadBatches() -> [Batch] {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
                let data = try? Data(contentsOf: url) else {
            return []
        }
        do {
            return try JSONDecoder().decode([Batch].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
                  return []
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
        .onAppear{
            batchData = loadBatches()
        }
    }
}

#Preview {
    NavigationStack{
        BatchListView()
    }}
