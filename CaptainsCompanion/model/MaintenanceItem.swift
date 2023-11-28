//
//  MaintenanceItem.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/28/23.
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
import SwiftUI
import SwiftData

@Model
final class MaintenanceItem: Identifiable, Hashable {
    var uuid: UUID
    var category: Category
    var name: String
    var monthsDue: Int
    var hoursDue: Int
    var acknowledged: Acknowledgement
    // InventoryItems
    // Checklist
    
    init(uuid: UUID, category: Category, name: String, monthsDue: Int, hoursDue: Int, acknowledged: Acknowledgement? = Acknowledgement.none) {
        self.uuid = uuid
        self.category = category
        self.name = name
        self.monthsDue = monthsDue
        self.hoursDue = hoursDue
        self.acknowledged = acknowledged ?? .none
    }
}

enum Acknowledgement: Codable, Hashable {
    case none
    case acknowledged(label: String)
    
    func isAcknowledged() -> Bool { self == .none }
}

extension MaintenanceItem {
        
    // TODO: implement MaintenanceItem.lastDoneDate()
    func lastDoneDate() -> Date {
        return Date()
    }
    
    // TODO: implement MaintenanceItem.lastDoneHours()
    func lastDoneHours() -> Int {
        return -1
    }
    
    // TODO: implement MaintenanceItem.monthsLeft()
    func monthsLeft() -> Int{
        return -1
    }
    
    // TODO: implement MaintenanceItem.hoursLeft()
    func hoursLeft() -> Int {
        return -1
    }
    
    // TODO: implement MaintenanceItem.getStatus()
    func getStatus() -> Status {
        return .pending
    }
        
    enum Status {
        case pending
        case warn
        case due
        case acknowledged
    }
}
