//
//  MaintenanceLogEntry.swift
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
import SwiftData
import CoreLocation

@Model
final class MaintenanceLogEntry : LogEntry {
    var uuid: UUID
    var created: Date
    var notes: String
    var attachments: [Attachment]
    var storedLocation: StoredLocation?
    var maintenanceItem: MaintenanceItem
    var hours: Int
    // var author: CrewMember
    // ChecklistExecution
    
    @Transient
    var location: CLLocationCoordinate2D? {
        get {
            if( storedLocation == nil ) { return nil }
            let sl = storedLocation!
            return CLLocationCoordinate2D(latitude: sl.latitude, longitude: sl.longitude)
        }
        set {
            if( newValue == nil ) { storedLocation = nil }
            let lc = newValue!
            storedLocation = StoredLocation(longitude: lc.longitude, latitude: lc.latitude)
        }
    }
    
    init(uuid: UUID, created: Date, notes: String, attachments: [Attachment], location: StoredLocation?, maintenanceItem: MaintenanceItem, hours: Int) {
        self.uuid = uuid
        self.created = created
        self.notes = notes
        self.attachments = attachments
        self.storedLocation = location
        self.maintenanceItem = maintenanceItem
        self.hours = hours
    }

    struct StoredLocation: Codable, Hashable {
        var longitude: Double
        var latitude: Double
    }
}

