//
//  BatchRowView.swift
//  Thea
//
//  Created by Szymon Wnuk on 15/03/2026.
//

import SwiftUI

struct BatchRowView: View {
    var batch: Batch

    var body: some View {
        HStack(alignment: .top){
            VStack(alignment: .leading){
                Text(batch.name)
                    .font(.headline)
                HStack{
                    Text(batch.status.displayName)
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.mainBlack)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(batch.status.batchColor.opacity(0.15))
                        .clipShape(.capsule)
                    if batch.isReady && batch.status != .finished {
                        Text("Ready")
                        .font(.caption.weight(.semibold))
                        .foregroundStyle(Color.green)
                        .padding(.horizontal, 10)
                        .padding(.vertical, 5)
                        .background(.green.opacity(0.15))
                        .clipShape(.capsule)
                    }
                }
                HStack{
                    Text(Image(systemName: "clock"))

                    if batch.isReady && batch.status != .finished {
                        Text("Ready for bottling")
                            .foregroundStyle(.secondary)
                    }
                    else if  batch.daysFermenting < 2 {
                        Text("\(batch.daysFermenting) day")
                            .foregroundStyle(.secondary)
                    } else {
                        Text("\(batch.daysFermenting) days")
                            .foregroundStyle(.secondary)
                    }}

            }
            Spacer()
            VStack(alignment: .trailing, spacing: 16) {
                Text("\(batch.volume, specifier: "%.1f") \(batch.unit.rawValue)")
                    .font(.subheadline)
                Image(systemName: "chevron.right")
                    .font(.footnote.weight(.semibold))
                    .foregroundStyle(.secondary)
            }

        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 6, y: 2)

    }
}

#Preview {
    BatchRowView(batch: Batch(name: "Kombucha", startDate: Date(), volume: 10, unit: .gallons, status: .fermenting))
}
