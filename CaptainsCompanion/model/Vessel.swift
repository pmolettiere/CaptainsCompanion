//
//  Item.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/21/23.
//
//    Copyright (C) <2023>  <Peter Molettiere>
//
//    This program is free software: you can redistribute it and/or modify
//    it under the terms of the GNU General Public License as published by
//    the Free Software Foundation, either version 3 of the License, or
//    (at your option) any later version.
//
//    This program is distributed in the hope that it will be useful,
//    but WITHOUT ANY WARRANTY; without even the implied warranty of
//    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
//    GNU General Public License for more details.
//
//    You should have received a copy of the GNU General Public License
//    along with this program.  If not, see <https://www.gnu.org/licenses/>.


import Foundation
import SwiftData
import SwiftUI

@Model
final class Vessel : Identifiable, Hashable {
    var uuid: UUID
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
    
    var fuelCapacityValue: Float = 0
    var fuelCapacityUnit: VolumeUnit = VolumeUnit.liters

    // Captain
    // Crew[]
    // Photo

    init(created: Date) {
        self.created = created
        self.uuid = UUID()
    }

    init(uuid: UUID, timestamp: Date, name: String, model: String, make: String, year: Int, hin: String, cruisingSpeedValue: Float, cruisingSpeedUnit: SpeedUnit, fuelConsumptionValue: Float, fuelConsumptionUnit: ConsumptionUnit, fuelCapacityValue: Float, fuelCapacityUnit: VolumeUnit) {
        self.uuid = uuid
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
        
        case knots = 1, mph, kph  // implicitly increments values…

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
        
        func convert(value: Float, to: SpeedUnit) -> Float {
            let m2k: Float  = 1.60934 // mile to kilometer
            let n2m: Float  = 1.15078 // nautical mile to mile
            let n2k: Float  = 1.852   // nautical mile to kilometer

            switch self {
            case .knots:
                switch to {
                case .mph:
                    return value * n2m
                case .kph:
                    return value * n2k;
                case .knots:
                    return value;
                }
            case .kph:
                switch to {
                case .knots:
                    return value * (1/n2k)
                case .mph:
                    return value * (1/m2k)
                case .kph:
                    return value
                }
            case .mph:
                switch to {
                case .knots:
                    return value * (1/n2m)
                case .kph:
                    return value * m2k
                case .mph:
                    return value
                }
            }
        }
    }
}

extension Vessel {
    enum ConsumptionUnit: Int, Codable, CaseIterable, Identifiable {

        case lph = 1, gph  // implicitly increments values…

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
        
        func convert(value: Float, to: ConsumptionUnit) -> Float {
            let g2l: Float  = 3.78541 // gallon to liter
            let l2g: Float  = 1 / g2l // liter to gallon
            
            switch self {
            case .lph:
                switch to {
                case .gph:
                    return value * l2g
                case .lph:
                    return value;
                }
            case .gph:
                switch to {
                case .lph:
                    return value * g2l
                case .gph:
                    return value
                }
            }
        }
    }
}

extension Vessel {
    enum VolumeUnit: Int, Codable, CaseIterable, Identifiable {
        
        case liters = 1, gallons  // implicitly increments values…
        
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
        
        func convert(value: Float, to: VolumeUnit) -> Float {
            let g2l: Float  = 3.78541 // gallon to liter
            let l2g: Float  = 1 / g2l // liter to gallon
            
            switch self {
            case .liters:
                switch to {
                case .gallons:
                    return value * l2g
                case .liters:
                    return value;
                }
            case .gallons:
                switch to {
                case .liters:
                    return value * g2l
                case .gallons:
                    return value
                }
            }
        }
    }
}

extension Vessel {
    enum DistanceUnit: Int, Codable, CaseIterable, Identifiable {
        
        case nm = 1, kilometers, miles  // implicitly increments values…
        
        var id: Self {
            return self
        }
        
        var label: LocalizedStringKey {
            switch self {
            case .nm:
                return LocalizedStringKey("units.distance.nm")
            case .kilometers:
                return LocalizedStringKey("units.distance.si")
            case .miles:
                return LocalizedStringKey("units.distance.en")
            }
        }
        
        func convert(value: Float, to: DistanceUnit) -> Float {
            let m2k: Float = 1.60934 // mile to kilometer
            let n2m: Float  = 1.15078 // nautical mile to mile
            let n2k: Float  = 1.852   // nautical mile to kilometer

            switch self {
            case .nm:
                switch to {
                case .miles:
                    return value * n2m
                case .kilometers:
                    return value * n2k;
                case .nm:
                    return value;
                }
            case .kilometers:
                switch to {
                case .nm:
                    return value * (1/n2k)
                case .miles:
                    return value * (1/m2k)
                case .kilometers:
                    return value
                }
            case .miles:
                switch to {
                case .nm:
                    return value * (1/n2m)
                case .kilometers:
                    return value * m2k
                case .miles:
                    return value
                }
            }
        }
    }
}
extension Vessel {
    func fuelCapacity(to: VolumeUnit) -> Float {
        fuelCapacityUnit.convert(value: fuelCapacityValue, to: to)
    }
    func fuelConsumption(to: ConsumptionUnit) -> Float {
        fuelConsumptionUnit.convert(value: fuelConsumptionValue, to: to)
    }
    func cruisingSpeed(to: SpeedUnit) -> Float {
        cruisingSpeedUnit.convert(value: cruisingSpeedValue, to: to)
    }
    
    func range(to: DistanceUnit) -> Float {
        let capacityL = fuelCapacityUnit.convert(value: fuelCapacityValue, to: .liters)
        let consumptionLph = fuelConsumptionUnit.convert(value: fuelConsumptionValue, to: .lph)
        let rangeHours = capacityL / consumptionLph
        let cruisingSpeedKnots = cruisingSpeedUnit.convert(value: cruisingSpeedValue, to: .knots)
        let rangeNm = cruisingSpeedKnots * rangeHours
        return DistanceUnit.nm.convert(value: rangeNm, to: to)
    }
}
