//
//  Barch+preview.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/03/2026.
//

import Foundation

struct BatchPreview {

    static let samples: [Batch] =
    [Batch(name: "Kombucha Mango", startDate: Date, volume: 10, unit: .liters, status: .fermenting)],
    [Batch(name: "Kombucha Ginger", startDate: Date, volume: 8, unit: .liters, status: .bottled)],
    [Batch(name: "Kombucha Classic", startDate: Date, volume: 5, unit: .liters, status: .finished)]
}
