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
    func configureCell(category: String?)
}

final class CategoriesCellViewModel {
    private weak var delegate: CategoriesCellViewModelDelegate?
    private var category: String?
    
    init(delegate: CategoriesCellViewModelDelegate?, category: String?) {
        self.delegate = delegate
        self.category = category
    }
}

extension CategoriesCellViewModel: CategoriesCellViewModelProtocol {
    func awakeFromNib() {
        delegate?.prepareUI()
    }
    
    func load() {
        if let category = category {
            delegate?.configureCell(category: category)
        }
    }
}
