//
//  CategoriesCell.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import UIKit

class CategoriesCell: UICollectionViewCell {

    @IBOutlet weak var categoriesLabel: UILabel!
    @IBOutlet weak var view: UIView!
    
    
    var viewModel: CategoriesCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
}

extension CategoriesCell: CategoriesCellViewModelDelegate {
    func prepareUIForSelectedState() {
        categoriesLabel.textColor = .white
        view.backgroundColor = .tintColor
        self.layer.cornerRadius = 10
    }
    
    func prepareUIForUnSelectedState() {
        self.layer.cornerRadius = 10
        categoriesLabel.textColor = .black
        view.backgroundColor = .white
        self.layer.borderWidth = 0.6
        self.layer.borderColor = tintColor.cgColor
    }
    
    func prepareUI() {
        self.layer.cornerRadius = 10
        self.layer.borderWidth = 0.6
        self.layer.borderColor = tintColor.cgColor
    }
    
    func configureCell(categoryText: String?) {
        categoriesLabel.text = categoryText
    }
}
