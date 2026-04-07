//
//  EmptyStateView.swift
//  Thea
//
//  Created by Szymon Wnuk on 07/04/2026.
//

import SwiftUI

struct EmptyStateView: View {
    var onAddTap: () -> Void
    var body: some View {
        VStack{
            Image(systemName: "leaf")
                .font(.largeTitle)
            Text("Add your first batch")
                .fontWeight(.bold)
            Button{
                onAddTap()
            } label: {
                HStack{
                    Text("Add batch")

                    Image(systemName: "plus")
                }

            }
        }
    }
}

#Preview {
    EmptyStateView(onAddTap: {})
}
