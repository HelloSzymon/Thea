//
//  Barch+preview.swift
//  Thea
//
//  Created by Szymon Wnuk on 08/03/2026.
//

import Foundation

struct BatchPreview {

    static let marchDate: Date = {
        var components = DateComponents()
        components.year = 2026
        components.month = 03
        components.day = 01

        return Calendar.current.date(from: components)!
    }()
    static let februaryDate: Date = {
        var components = DateComponents()
        components.year = 2026
        components.month = 02
        components.day = 14

        return Calendar.current.date(from: components)!
    }()

    static let samples: [Batch] =
    [Batch(name: "Kombucha Mango", startDate: marchDate, volume: 10, unit: .liters, status: .fermenting),
    Batch(name: "Kombucha Ginger", startDate: februaryDate, volume: 8, unit: .liters, status: .bottled),
    Batch(name: "Kombucha Classic", startDate: Date(), volume: 5, unit: .liters, status: .finished)]
}
