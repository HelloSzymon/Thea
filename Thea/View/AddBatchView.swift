//
//  AddBatchView.swift
//  Thea
//
//  Created by Szymon Wnuk on 11/03/2026.
//

import SwiftUI

struct AddBatchView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var batch = Batch.init(name: "", startDate: Date(), volume: 0, unit: .liters, status: .fermenting)
    var onSave: (Batch) -> Void
    private var isDisabled: Bool {
        batch.volume == 0 || batch.name.isEmpty
    }
    var body: some View {
        VStack{
          BatchFormView(batch: $batch)

            Button{
               let trimmed =  batch.name.trimmingCharacters(in: .whitespacesAndNewlines)
                batch.name = trimmed
                    onSave(batch)
                dismiss()
            }label: {
                Text("Save")
            }
            .disabled(isDisabled)
        }
    }
}

#Preview {
    AddBatchView(onSave: { batch in
        print(batch)
    })
}
