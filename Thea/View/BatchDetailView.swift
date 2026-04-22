//
//  BatchDetailView.swift
//  Thea
//
//  Created by Szymon Wnuk on 10/03/2026.
//

import SwiftUI

struct BatchDetailView: View {
    @ObservedObject var vm: BatchViewModel
    @Binding var batch: Batch

    private var editableBatchBinding: Binding<Batch>? {
        guard let index = vm.batchData.firstIndex(where: { $0.id == batch.id }) else {
            return nil
        }

        return Binding(
            get: { vm.batchData[index] },
            set: { vm.batchData[index] = $0 }
        )
    }

    var body: some View {
        ScrollView{
            VStack(spacing: 16){
                VStack(alignment: .leading){
                    Text(batch.name)
                        .font(.title2)
                        .bold()
                    Text(batch.status.displayName)
                        .foregroundStyle(batch.status.batchColor)
                        .font(.subheadline)
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
                VStack(alignment: .leading){
                    HStack{
                        Text("Volume:").font(.caption)
                            .foregroundStyle(.secondary)
                        Text("\(batch.volume) \(batch.unit.rawValue)")

                    }
                    Text(batch.startDate.formatted())
                    Text("\(batch.daysFermenting)")
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
                    VStack(alignment: .leading){
                    Text("Fermentation progress")
                        .font(.headline)
                        ProgressView(value: Double(batch.progress), total: Double(batch.fermentationTargetDate))
                        .progressViewStyle(.linear)

                        Text("\(batch.daysRemaining) days remaining")
                            .font(.caption)
                            .foregroundStyle(.secondary)
                        if batch.isReady {
                            Text("Ready 🍺")
                                .font(.caption)
                                .padding(6)
                                .background(.green.opacity(0.2))
                                .cornerRadius(8)
                        }}
                    .frame(maxWidth: .infinity, alignment: .leading)
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
            }}.padding()
            .toolbar{
                ToolbarItem(placement: .topBarLeading) {
                    if let editableBatchBinding {
                        NavigationLink {
                            EditBatchView(batch: editableBatchBinding)
                        } label: {
                            Text("Edit")
                        }
                    }
                }
            }
    }
}

#Preview {
    BatchDetailView(vm: BatchViewModel(), batch: .constant(BatchPreview.samples[0]))
}
