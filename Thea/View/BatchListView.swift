//
//  BatchListView.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/03/2026.
//

import SwiftUI

struct BatchListView: View {

    private var batchData : [Batch] =  BatchPreview.samples
    var body: some View {
        List(batchData) { batch in
                    Text(batch.name)
                    Text(batch.status.rawValue)
            Text("Days fermenting: \(batch.daysFermenting)")

        }
    }
}

#Preview {
    BatchListView()
}
