//
//  Batch.swift
//  Thea
//
//  Created by Szymon Wnuk on 07/03/2026.
//

import Foundation
import SwiftUI

struct Batch: Identifiable, Codable {
    var id = UUID()
    var name: String
    var startDate: Date
    var volume: Double
    var unit: VolumeUnit
    var status: BatchStatus

    var daysFermenting: Int {
        let components = Calendar.current.dateComponents([.day], from: startDate, to: Date())
        return max(components.day ?? 0, 0)
    }
}

enum BatchStatus: String, Codable {
    case fermenting
    case bottled
    case finished

    var displayName: String {
        switch self {
        case .fermenting:
            "Fermenting"
        case .bottled:
            "Bottled"
        case .finished:
            "Finished"
        }
    }
    var batchColor: Color {
        switch self {
        case .fermenting:
                .green
        case .bottled:
                .orange
        case .finished:
                .gray
        }
    }

}
