//
//  Source.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import Foundation

/// Model representing the source of an article
struct Source: Decodable, Equatable {
    let id: String?
    let name: String
}
