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
        NavigationStack{
            List(batchData) { batch in
                    NavigationLink(destination: BatchDetailView(batch: batch), label:                     {
                        VStack(alignment: .leading){
                    Text(batch.name)
                    Text(batch.status.displayName)
                    Text("Days fermenting: \(batch.daysFermenting)")
                }})}

        }
    }
}

#Preview {
    BatchListView()
}
