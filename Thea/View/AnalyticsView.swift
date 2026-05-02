//
//  AnalyticsView.swift
//  Thea
//
//  Created by Szymon Wnuk on 30/04/2026.
//

import SwiftUI

private enum AnalyticsPalette {
    /// #4F8A66 — primary z briefu Thea
    static let primaryGreen = Color(red: 79 / 255, green: 138 / 255, blue: 102 / 255)
}

struct AnalyticsView: View {
    let batches: [Batch]

    private let columns = [
        GridItem(.flexible(), spacing: 12),
        GridItem(.flexible(), spacing: 12),
    ]

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
        ScrollView {
            VStack(alignment: .leading, spacing: 20) {
                Text("Overview")
                    .font(.title2.weight(.semibold))
                    .foregroundStyle(Color.mainBlack)

                Text("Number of Batches in Each Stage")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                    .fixedSize(horizontal: false, vertical: true)

                LazyVGrid(columns: columns, spacing: 12) {
                    AnalyticsCard(title: "Fermenting", value: fermentingCount)
                    AnalyticsCard(title: "Ready", value: readyCount)
                    AnalyticsCard(title: "Bottled", value: bottledCount)
                    AnalyticsCard(title: "Finished", value: finishedCount)
                }
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.horizontal, 20)
            .padding(.vertical, 16)
        }
        .background(Color("mainBackground").ignoresSafeArea())
    }
}

#Preview {
    NavigationStack {
        AnalyticsView(batches: BatchPreview.samples)
            .navigationTitle("Analytics")
    }
}

private struct AnalyticsCard: View {
    let title: String
    let value: Int

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(title.uppercased())
                .font(.caption.weight(.semibold))
                .foregroundStyle(.secondary)
                .tracking(0.6)

            Text("\(value)")
                .font(.system(size: 32, weight: .semibold, design: .rounded))
                .foregroundStyle(AnalyticsPalette.primaryGreen)
                .minimumScaleFactor(0.8)
                .lineLimit(1)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(16)
        .background(.thinMaterial, in: RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.06), radius: 8, y: 4)
    }
}
