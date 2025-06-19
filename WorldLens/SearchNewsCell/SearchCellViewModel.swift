//
//  SearchCellViewModel.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import Foundation

protocol SearchCellViewModelProtocol {
    func awakeFromNib()
    func load()
}

protocol SearchCellViewModelDelegate: AnyObject {
    func prepareUI()
    func configureCell(new: Article?)
    func prepareBannerImage(with urlString: String?)
}

final class SearchCellViewModel {
    private weak var delegate: SearchCellViewModelDelegate?
    private var new: Article?
    
    init(delegate: SearchCellViewModelDelegate?, new: Article?) {
        self.delegate = delegate
        self.new = new
    }
}

extension SearchCellViewModel: SearchCellViewModelProtocol {
    func awakeFromNib() {
        delegate?.prepareUI()
    }
    
    func load() {
        if let new = new {
            delegate?.configureCell(new: new)
        }
    }
}
