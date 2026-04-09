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
                        .font(.title)
                        .bold()
                    Text(batch.status.displayName)
                        .foregroundStyle(batch.status.batchColor)
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
                VStack(alignment: .leading){
                    Text("Volume: \(batch.volume) \(batch.unit.rawValue)")
                    Text(batch.startDate.formatted())
                    Text("\(batch.daysFermenting)")
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
                    VStack(alignment: .leading){
                    Text("Fermentation progress")
                        .font(.headline)
                    ProgressView(value: Double(batch.daysFermenting), total: 14)
                        .progressViewStyle(.linear)
                        .padding()
                }
                .padding()
                .background(.thinMaterial)
                .cornerRadius(15)
            }}.padding()
    }
}

#Preview {
    BatchDetailView(batch: BatchPreview.samples[0])
}
