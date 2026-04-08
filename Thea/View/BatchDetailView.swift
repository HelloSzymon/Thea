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
        VStack(spacing: 16){
            Text(batch.name)
                .font(.title)
                    .bold()
            Text(batch.status.displayName)
                .foregroundStyle(batch.status.batchColor)
            Divider()
            Text("\(batch.volume) \(batch.unit.rawValue)")
            Text(batch.startDate.formatted())
            Text("\(batch.daysFermenting)")
            Divider()


            ProgressView(value: 1, total: 14)
                .progressViewStyle(.linear)
                .padding()
        }}
}

#Preview {
    BatchDetailView(batch: BatchPreview.samples[0])
}
