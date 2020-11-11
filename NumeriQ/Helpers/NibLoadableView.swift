//
//  NibLoadableView.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import UIKit

/// Protocol for view that can be loaded via a nib file. Offers functions to get its name and to create a view from it.
public protocol NibLoadableView: class {

    /// The nib's name.
    static var nibName: String { get }

}

public extension NibLoadableView where Self: UIView {

    /// The nib's name. Defaults to the filename without its extension.
    static var nibName: String {
        String(describing: self)
    }


    /// Creates a nib file using the class name as its name.
    /// - Returns: A nib file.
    static func nib() -> UINib {
        UINib(nibName: nibName, bundle: nil)
    }

    /// Instantiates a `UIView` from a XIB file and adds it as a subview.
    /// - Returns: A `UIView` that can be configured if necessary.
    @discardableResult func loadFromNib() -> UIView {
        let nib = Self.nib()
        let view = nib.instantiate(withOwner: self, options: nil)[0] as! UIView
        view.backgroundColor = .clear
        addSubview(view)

        return view
    }

}
