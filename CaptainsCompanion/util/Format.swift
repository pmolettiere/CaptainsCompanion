//
//  Format.swift
//  CaptainsCompanion
//
//  Created by Peter Molettiere on 11/25/23.
//

import Foundation

struct Format {
    static let singleton = Format()
    
    var intFormat: NumberFormatter
    var floatFormat: NumberFormatter

    init() {
        self.intFormat = NumberFormatter()
        self.floatFormat = NumberFormatter()
        intFormat.numberStyle = NumberFormatter.Style.none;
        floatFormat.numberStyle = NumberFormatter.Style.decimal;
        floatFormat.minimumFractionDigits = 1
        floatFormat.maximumFractionDigits = 2
    }
}
