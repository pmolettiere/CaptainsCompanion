//
//  Category.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/28/23.
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

@Model
final class Category {
    var uuid: UUID
    var vessel: Vessel
    var name: String
    var notes: String
    
    init(uuid: UUID, vessel: Vessel, name: String, notes: String) {
        self.uuid = uuid
        self.vessel = vessel
        self.name = name
        self.notes = notes
    }
}
