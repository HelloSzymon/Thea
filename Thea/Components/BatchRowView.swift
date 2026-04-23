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
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 18, style: .continuous))
        .shadow(color: .black.opacity(0.12), radius: 6, y: 2)
        .padding()
    }
}

#Preview {
    BatchRowView(batch: Batch(name: "Kombucha", startDate: Date(), volume: 10, unit: .gallons, status: .finished))
}
