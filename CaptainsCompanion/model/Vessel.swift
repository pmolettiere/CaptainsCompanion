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
    var uuid: UUID = UUID()
    var created: Date = Date.now
    var name: String = String(localized: "vessel.name.default", comment: "Default name for unnamed vessel")
    var model: String = String(localized: "vessel.model.default", comment: "Default model for vessel")
    var make: String = String(localized: "vessel.make.default", comment: "Default make/manufacturer for vessel")
    var year: Int = 2004;
    var hin: String = ""

    var cruisingSpeedValue: Float = 7.0
    var cruisingSpeedUnit: SpeedUnit = SpeedUnit.knots

    var fuelConsumptionValue: Float = 4.73
    var fuelConsumptionUnit: ConsumptionUnit = ConsumptionUnit.lph
    
    var fuelCapacityValue: Int = 0
    var fuelCapacityUnit: VolumeUnit = VolumeUnit.liters

    // Captain
    // Crew[]
    // Photo

    init(created: Date) {
        self.created = created
    }

    init(uuid: UUID, timestamp: Date, name: String, model: String, make: String, year: Int, hin: String, cruisingSpeedValue: Float, cruisingSpeedUnit: SpeedUnit, fuelConsumptionValue: Float, fuelConsumptionUnit: ConsumptionUnit, fuelCapacityValue: Int, fuelCapacityUnit: VolumeUnit) {
        self.uuid = uuid;
        self.created = timestamp
        self.name = name
        self.model = model
        self.make = make
        self.year = year
        self.hin = hin
        self.cruisingSpeedValue = cruisingSpeedValue
        self.cruisingSpeedUnit = cruisingSpeedUnit
        self.fuelConsumptionValue = fuelConsumptionValue
        self.fuelConsumptionUnit = fuelConsumptionUnit
        self.fuelCapacityValue = fuelCapacityValue
        self.fuelCapacityUnit = fuelCapacityUnit
    }
    
}

extension Vessel {
    enum SpeedUnit: Int, Codable, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        var label: LocalizedStringKey {
            switch self {
            case .knots:
                return LocalizedStringKey("units.speed.nautical")
            case .kph:
                return LocalizedStringKey("units.speed.si")
            case .mph:
                return LocalizedStringKey("units.speed.en")
            }
        }
        
        case knots = 1, mph, kph  // implicitly increments values…
    }
}

extension Vessel {
    enum ConsumptionUnit: Int, Codable, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        var label: LocalizedStringKey {
            switch self {
            case .lph:
                return LocalizedStringKey("units.fuelconsumption.si")
            case .gph:
                return LocalizedStringKey("units.fuelconsumption.en")
            }
        }
        
        case lph = 1, gph  // implicitly increments values…
    }
}

extension Vessel {
    enum VolumeUnit: Int, Codable, CaseIterable, Identifiable {
        var id: Self {
            return self
        }
        var label: LocalizedStringKey {
            switch self {
            case .liters:
                return LocalizedStringKey("units.volume.si")
            case .gallons:
                return LocalizedStringKey("units.volume.en")
            }
        }
        
        case liters = 1, gallons  // implicitly increments values…
    }
}
