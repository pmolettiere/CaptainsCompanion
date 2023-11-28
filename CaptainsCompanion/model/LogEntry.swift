//
//  LogEntry.swift
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

protocol LogEntry {
    var uuid: UUID { get set }
    var created: Date { get set }
    var notes: String { get set }
    var attachments: [Attachment] { get set }
    var location: CLLocationCoordinate2D? { get set }
    // var author: CrewMember { get set }
}
