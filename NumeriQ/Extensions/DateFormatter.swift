//
//  DateFormatter.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import Foundation

extension DateFormatter {

    static var urlFormatter: Self {
        let formatter = Self()
        formatter.dateFormat = "yyyy-MM-dd"
        return formatter
    }

}
