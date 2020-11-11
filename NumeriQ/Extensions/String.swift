//
//  String.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import Foundation

extension String {

    var urlEscaped: String {
        addingPercentEncoding(withAllowedCharacters: .urlHostAllowed) ?? ""
    }

}
