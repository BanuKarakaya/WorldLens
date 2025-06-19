//
//  NewsCellViewModel.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import Foundation

protocol NewsCellViewModelProtocol {
    func awakeFromNib()
    func load()
}

protocol NewsCellViewModelDelegate: AnyObject {
    func prepareUI()
    func configureCell(new: Article)
}

final class NewsCellViewModel {
    private weak var delegate: NewsCellViewModelDelegate?
    private var new: Article?
    
    init(delegate: NewsCellViewModelDelegate?, new: Article?) {
        self.delegate = delegate
        self.new = new
    }
}

extension NewsCellViewModel: NewsCellViewModelProtocol {
    func awakeFromNib() {
        delegate?.prepareUI()
    }
    
    func load() {
        if let new = new {
            delegate?.configureCell(new: new)
        }
    }
}
