//
//  EditBatchView.swift
//  Thea
//
//  Created by Szymon Wnuk on 23/03/2026.
//

import SwiftUI

struct EditBatchView: View {
    @Binding var batch: Batch
    private let numberFormatter: NumberFormatter = {
        var numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
//    var onSave: (Batch) -> Void

    var body: some View {
        VStack{
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
}

#Preview {
    EditBatchView(batch: .constant(
        Batch(name: "Test", startDate: Date(), volume: 100, unit: .liters, status: .bottled)
    ))
}
