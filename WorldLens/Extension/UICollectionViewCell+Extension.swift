//
//  UICollectionViewCell+Extension.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import UIKit

extension UICollectionViewCell {
    public static var identifier: String {
        return String(describing: self)
    }
   
    public static var nib: UINib {
        return UINib(nibName: identifier, bundle: nil)
    }
}
