//
//  NewsDetailPageViewModel.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import Foundation

protocol NewsDetailPageViewModelProtocol {
    func viewDidLoad()
}

protocol NewsDetailPageViewModelDelegate: AnyObject {
    func configure(selectedNew: Article)
    func prepareBannerImage(with urlString: String?)
    func prepareUI()
}

final class NewsDetailPageViewModel {
    private weak var delegate: NewsDetailPageViewModelDelegate?
    var selectedNew: Article?
    
    init(delegate: NewsDetailPageViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension NewsDetailPageViewModel: NewsDetailPageViewModelProtocol {
    func viewDidLoad() {
        delegate?.configure(selectedNew: selectedNew!)
        delegate?.prepareUI()
    }
}
