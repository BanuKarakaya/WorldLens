//
//  UICollectionView+Extension.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import UIKit

extension UICollectionView {
    
    public func register(cellType:UICollectionViewCell.Type){
        register(cellType.nib, forCellWithReuseIdentifier: cellType.identifier)
    }
    
    public func dequeCell<T: UICollectionViewCell>(cellType: T.Type, indexPath: IndexPath) -> T {
        guard let cell = dequeueReusableCell(withReuseIdentifier: cellType.identifier, for: indexPath) as? T else {fatalError()}
        return cell
    }
}

