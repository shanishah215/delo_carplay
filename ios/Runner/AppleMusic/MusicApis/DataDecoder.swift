//
//  DataDecoder.swift
//  Runner
//
//  Created by Chandan Sharda on 19/04/24.
//

import Foundation

/// `DateDecoder` manages date handling with the Apple Music API.
class DateDecoder {
    let iso8601Decoder: ISO8601DateFormatter
    let yyyyMMddDecoder: DateFormatter
    let yyyyMMDecoder: DateFormatter

    init() {
        iso8601Decoder = ISO8601DateFormatter()
        iso8601Decoder.formatOptions = .withInternetDateTime
        yyyyMMddDecoder = DateFormatter()
        yyyyMMddDecoder.dateFormat = "yyyy-MM-dd"
        yyyyMMDecoder = DateFormatter()
        yyyyMMDecoder.dateFormat = "yyyy-MM"
    }

    func decode(_ value: String) -> Date? {
        // In the Apple Music API, some dates are ISO 8601, some are YYYY-MM-DD and some are YYYY-MM, try to get a usable date out.
        return iso8601Decoder.date(from: value) ?? yyyyMMddDecoder.date(from: value) ?? yyyyMMDecoder.date(from: value)
    }
}
