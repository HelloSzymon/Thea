//
//  AnalitycsView.swift
//  Thea
//
//  Created by Szymon Wnuk on 30/04/2026.
//

import SwiftUI

struct AnalitycsView: View {
    let batches: [Batch]

    var fermentingCount: Int {
        batches.filter { $0.status == .fermenting }.count
    }
    var readyCount: Int {
        batches.filter { $0.isReady && $0.status != .finished }.count
    }
    var bottledCount: Int {
        batches.filter { $0.status == .bottled }.count
    }
    var finishedCount: Int {
        batches.filter { $0.status == .finished }.count
    }


    var body: some View {
        VStack{
            Text("Fermenting: \(fermentingCount)")
            Text("Ready: \(readyCount)")
            Text("Bottled: \(bottledCount)")
            Text("Finished: \(finishedCount)")
        }
    }
}

#Preview {
    AnalitycsView(batches: BatchPreview.samples)
}
