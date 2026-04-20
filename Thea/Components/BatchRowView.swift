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
                        .font(.subheadline)
                        .foregroundStyle(batch.status.batchColor)
                }
                HStack{
                    Text(Image(systemName: "clock"))
                    Text("\(batch.daysFermenting) days")
                        .foregroundStyle(.secondary)
                }

            }
            Spacer()
            Text("\(batch.volume, specifier: "%.1f") \(batch.unit.rawValue)")
                .font(.subheadline)

        }
        .padding()
    }
}

#Preview {
    BatchRowView(batch: Batch(name: "Kombucha", startDate: Date(), volume: 10, unit: .gallons, status: .finished))
}
