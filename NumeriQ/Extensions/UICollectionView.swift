//
//  UICollectionView.swift
//  NumeriQ
//
//  Created by Caina Souza on 2020-11-10.
//  Copyright © 2020 Quebecor. All rights reserved.
//

import UIKit

public extension UICollectionView {

    /// Register a `UICollectionViewCell` conforming to `ReusableView`. `ReusableView.defaultReuseIdentifier` will be
    /// used as the reuse identifier.
    /// - Parameter : A generic inferred type for a cell.
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView {
        register(T.self, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// Register a `UICollectionViewCell` conforming to `ReusableView` and `NibLoadableView`, from a XIB file.
    /// `ReusableView.defaultReuseIdentifier` will be used as the reuse identifier and `NibLoadableView.nibName`
    /// will be used to load the XIB file.
    /// - Parameter : A generic inferred type for a cell.
    func register<T: UICollectionViewCell>(_: T.Type) where T: ReusableView, T: NibLoadableView {
        let bundle = Bundle(for: T.self)
        let nib = UINib(nibName: T.nibName, bundle: bundle)

        register(nib, forCellWithReuseIdentifier: T.defaultReuseIdentifier)
    }

    /// Dequeues a cell conforming to `ReusableView` and `NibLoadableView`.
    /// - Parameter indexPath: An index path for the cell to be dequeued.
    /// - Returns: A dequeued `UICollectionViewCell`.
    func dequeueReusableCell<T: UICollectionViewCell>(for indexPath: IndexPath) -> T where T: ReusableView {
        guard let cell = dequeueReusableCell(withReuseIdentifier: T.defaultReuseIdentifier,
                                             for: indexPath) as? T else {
            fatalError("Could not dequeue cell with identifier: \(T.defaultReuseIdentifier)")
        }

        return cell
    }

}
