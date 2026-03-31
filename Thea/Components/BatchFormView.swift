//
//  BatchFormView.swift
//  Thea
//
//  Created by Szymon Wnuk on 31/03/2026.
//

import SwiftUI

struct BatchFormView: View {
    @Binding var batch: Batch

    private let numberFormatter: NumberFormatter = {
        var numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    var body: some View {

            Form {
                TextField("Name", text: $batch.name)
                TextField("Volume", value: $batch.volume, formatter: numberFormatter)
                Picker("Unit", selection: $batch.unit) {
                    Text("Liters").tag(VolumeUnit.liters)
                    Text("Gallons").tag(VolumeUnit.gallons)

                }
                DatePicker("Start date", selection: $batch.startDate, displayedComponents: .date)
            }


    }
}

#Preview {
    BatchFormView(batch: .constant(Batch(name: "", startDate: .now, volume: 20, unit: .gallons, status: .bottled)))
}
