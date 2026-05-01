//
//  AnalitycsView.swift
//  Thea
//
//  Created by Szymon Wnuk on 30/04/2026.
//

import SwiftUI

struct AnalyticsView: View {
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
            AnalyticsCard(titleText: "Fermenting:", number: "\(fermentingCount)")
            AnalyticsCard(titleText: "Ready:", number: "\(readyCount)")
            AnalyticsCard(titleText: "Bottled:", number: "\(bottledCount)")
            AnalyticsCard(titleText: "Finished:", number: "\(finishedCount)")
      
        }
    }
}

#Preview {
    AnalyticsView(batches: BatchPreview.samples)
}

struct AnalyticsCard: View {

    var titleText: String = ""
    var number: String = ""

    var body: some View {

        VStack{
            Text(titleText)
                .font(.title2)
            Text(number)
                .font(.subheadline)
        }
        .padding()
        .background(.thinMaterial)
        .cornerRadius(16)

    }
}
