//
//  ReusableView.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import UIKit

public protocol ReusableView: class {

    /// The reusable identifier for the current view.
    static var defaultReuseIdentifier: String { get }

}

public extension ReusableView where Self: UIView {

    /// The reusable identifier for the current view. Defaults to the filename without its extension.
    static var defaultReuseIdentifier: String {
        String(describing: self)
    }

}
