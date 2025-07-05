//
//  CategoriesCellViewModel.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import Foundation

protocol CategoriesCellViewModelProtocol {
    func awakeFromNib()
    func load()
}

protocol CategoriesCellViewModelDelegate: AnyObject {
    func prepareUI()
    func configureCell(categoryText: String?)
    func prepareUIForSelectedState()
    func prepareUIForUnSelectedState()
}

final class CategoriesCellViewModel {
    private weak var delegate: CategoriesCellViewModelDelegate?
    private var categoryText: String?
    private var isSelected: Bool
    
    init(delegate: CategoriesCellViewModelDelegate?,
         categoryText: String?,
         isSelected: Bool) {
        self.delegate = delegate
        self.categoryText = categoryText
        self.isSelected = isSelected
    }
}

extension CategoriesCellViewModel: CategoriesCellViewModelProtocol {
    func awakeFromNib() {
        delegate?.prepareUI()
    }
    
    func load() {
        if let text = categoryText {
            delegate?.configureCell(categoryText: text)
        }
        
        if isSelected {
            delegate?.prepareUIForSelectedState()
        } else {
            delegate?.prepareUIForUnSelectedState()
        }
    }
}
