//
//  Item.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
//


import Foundation
import SwiftData
import SwiftUI

@Model
final class Vessel {
    var created: Date = Date.now
    var name: String = String(localized: "vessel.unnamed.default", comment: "Default name for unnamed vessel")
    var model: String = String(localized: "vessel.model.default", comment: "Default model for vessel")
    var make: String = String(localized: "vessel.make.default", comment: "Default make/manufacturer for vessel")
    var year: Int?
    var hin: String?
    var cruisingSpeed: Int?
    var fuelConsumptionLph: Float?
    var fuelCapacityLiters: Int?
    // Captain
    // Crew[]
    // Photo

    init(created: Date) {
        self.created = created
    }

    init(timestamp: Date, name: String, model: String, make: String, year: Int?, hin: String?,
         cruisingSpeed: Int?, fuelConsumptionLph: Float?, fuelCapacityLiters: Int?) {
        self.created = timestamp
        self.name = name
        self.model = model
        self.make = make
        self.year = year
        self.hin = hin
        self.cruisingSpeed = cruisingSpeed
        self.fuelConsumptionLph = fuelConsumptionLph
        self.fuelCapacityLiters = fuelCapacityLiters
    }
}
