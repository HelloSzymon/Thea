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
        VStack{
            Text(batch.name)
            Text(batch.status.displayName)
            Text("\(batch.volume) \(batch.unit.rawValue)")
            Text("\(batch.daysFermenting)")
            Text(batch.startDate.formatted())
        }}
}

#Preview {
    BatchDetailView(batch: BatchPreview.samples[0])
}
