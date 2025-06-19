//
//  SearchViewModel.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import Foundation

protocol SearchViewModelProtocol {
    func numberOfItems() -> Int
    func numberOfItemsForCategories() -> Int
    func newAtIndex(index: Int) -> Article?
    func categoryAtIndex(index: Int) -> String?
    func viewDidLoad()
    func didSelectItemAt(index: Int)
}

protocol SearchViewModelDelegate: AnyObject {
    func reloadData()
    func prepareCollectionView()
    func prepareUI()
    func navigateToDetailVC(selectedCell: Article?)
}

final class SearchViewModel {
    private weak var delegate: SearchViewModelDelegate?
    var breakingNews: [Article]?
    var categories = ["Breaking News", "Entertainment", "Health", "Science", "Sports"]
    private let networkManager: NetworkManagerInterface
    
    init(delegate: SearchViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func fetchBreakingNews() {
        networkManager.getBreakingNews { responseData in
            switch responseData {
            case .success(let responseData):
                self.breakingNews = responseData.articles
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(responseData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    func didSelectItemAt(index: Int) {
        var selectedCell: Article?
        
        selectedCell = breakingNews?[index]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func categoryAtIndex(index: Int) -> String? {
        let category = categories[index]
        return category
    }
    
    func numberOfItemsForCategories() -> Int {
        categories.count ?? 0
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        fetchBreakingNews()
    }
    
    func newAtIndex(index: Int) -> Article? {
        if let new = breakingNews?[index] {
            return new
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        breakingNews?.count ?? 0
    }
}
