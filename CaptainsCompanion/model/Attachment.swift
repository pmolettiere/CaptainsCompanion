//
//  Attachment.swift
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

@Model
final class Attachment {
    var uuid: UUID
    var name: String
    var type: AttachmentType
    var url: URL?
    @Attribute(.externalStorage)
    var data: Data?
    
    init(uuid: UUID, name: String, type: AttachmentType, url: URL? = nil, data: Data? = nil) {
        self.uuid = uuid
        self.name = name
        self.type = type
        self.url = url
        self.data = data
    }
}

enum AttachmentType: Int, Codable {
    case file = 1, url, photo, audio
}


