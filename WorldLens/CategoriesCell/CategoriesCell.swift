//
//  CategoriesCell.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import UIKit

class CategoriesCell: UICollectionViewCell {

    @IBOutlet weak var categoriesLabel: UILabel!
    
    var viewModel: CategoriesCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
}

extension CategoriesCell: CategoriesCellViewModelDelegate {
    func prepareUI() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.6
        self.layer.borderColor = tintColor.cgColor
    }
    
    func configureCell(category: String?) {
        categoriesLabel.text = category
    }
}
