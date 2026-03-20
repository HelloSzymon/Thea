//
//  BatchViewModel.swift
//  Thea
//
//  Created by Szymon Wnuk on 20/03/2026.
//
    import Foundation
    import SwiftUI
    import Combine

class BatchViewModel: ObservableObject {
    @Published var batchData : [Batch] =  BatchPreview.samples

    func saveBatches(batch: [Batch]) {
        do {
            let data = try JSONEncoder().encode(batch)
            let documentDirectory = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first!
            let fileURL = documentDirectory.appendingPathComponent("batch.json")
            try data.write(to: fileURL)
        } catch {
            print("Error saving JSON: \(error)")
        }
    }

    func loadBatches() -> [Batch] {
        guard let url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).first,
                let data = try? Data(contentsOf: url) else {
            return []
        }
        do {
            return try JSONDecoder().decode([Batch].self, from: data)
        } catch {
            print("Error decoding JSON: \(error)")
                  return []
        }
    }
}
