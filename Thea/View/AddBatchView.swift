//
//  AddBatchView.swift
//  Thea
//
//  Created by Szymon Wnuk on 11/03/2026.
//

import SwiftUI

struct AddBatchView: View {
    @State private var name = ""
    @State private var volume = 0.0
    @State private var unit : VolumeUnit = .liters
    @State private var startDate: Date = Date()
    private let numberFormatter: NumberFormatter = {
        var numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    var onSave: (Batch) -> Void
    var body: some View {
        VStack{
            Form {
                TextField("Name", text: $name)
                TextField("Volume", value: $volume, formatter: numberFormatter)
                Picker("Unit", selection: $unit) {
                    Text("Liters").tag(VolumeUnit.liters)
                    Text("Gallons").tag(VolumeUnit.gallons)

                }
                DatePicker("Start date", selection: $startDate, displayedComponents: .date)
            }

            Button{
                    let newBatch =  Batch(name: name, startDate: startDate, volume: volume, unit: unit, status: .fermenting)
                    onSave(newBatch)

            }label: {
                Text("Save")
            }
        }
    }
}

#Preview {
    AddBatchView(onSave: { batch in
        print(batch)
    })
}
