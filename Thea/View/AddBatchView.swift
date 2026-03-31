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
    var body: some View {
        VStack{
          BatchFormView(batch: $batch)

            Button{
                    onSave(batch)
                dismiss()
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
