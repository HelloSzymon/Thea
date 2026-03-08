//
//  BatchListView.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/03/2026.
//

import SwiftUI

struct BatchListView: View {

    private var batchData: BatchPreview = []
    var body: some View {
        List {
            ForEach(batchData, \id.self) {
                VStack{
                    Text($0.name)
                    Text($0.startDate)
                    Text($0.volume)
                    Text($0.unit)
                    Text($0.status)
                }}
        }
    }
}

#Preview {
    BatchListView()
}
