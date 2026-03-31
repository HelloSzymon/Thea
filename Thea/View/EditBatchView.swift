//
//  EditBatchView.swift
//  Thea
//
//  Created by Szymon Wnuk on 23/03/2026.
//

import SwiftUI

struct EditBatchView: View {
    @Environment(\.dismiss) private var dismiss
    @Binding var batch: Batch
    private let numberFormatter: NumberFormatter = {
        var numberFormatter = NumberFormatter()
        numberFormatter.numberStyle = .decimal
        return numberFormatter
    }()
    var onSave: () -> Void

    var body: some View {
        VStack{
            BatchFormView(batch: $batch)
        }
        .toolbar{
            ToolbarItem(placement: .topBarLeading) {
                Button {
                    onSave()
                    dismiss()
                }label: {
                    Text("Done")

                }.disabled(batch.name.isEmpty)
            }
        }

    }
}

#Preview {
    EditBatchView(batch: .constant(
        Batch(name: "Test", startDate: Date(), volume: 100, unit: .liters, status: .bottled)
    ), onSave: {
        print("")
    })
}
