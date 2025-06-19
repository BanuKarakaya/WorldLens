//
//  HomeViewModel.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    
    init(delegate: HomeViewModelDelegate?) {
        self.delegate = delegate
    }
}

extension HomeViewModel: HomeViewModelProtocol {
    func viewDidLoad() {
        delegate?.prepareCollectionView()
    }
}
