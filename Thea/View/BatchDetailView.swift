//
//  BatchDetailView.swift
//  Thea
//
//  Created by Szymon Wnuk on 10/03/2026.
//

import SwiftUI

struct BatchDetailView: View {

    var batch: Batch
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
                        ProgressView(value: Double(batch.progress), total: 14)
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
    }
}

#Preview {
    BatchDetailView(batch: BatchPreview.samples[0])
}
