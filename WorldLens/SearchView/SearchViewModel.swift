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
    func searchBarCancelButtonClicked()
    func searchBarSearchButtonClicked(searchText: String?)
}

protocol SearchViewModelDelegate: AnyObject {
    func reloadData()
    func prepareCollectionView()
    func prepareUI()
    func navigateToDetailVC(selectedCell: Article?)
    func prepareSearchController()
}

final class SearchViewModel {
    private weak var delegate: SearchViewModelDelegate?
    var breakingNews: [Article]?
    var searchNews: [Article]?
    var isSearching = false
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
    
    func fetchSearchArticles(searchedText: String) {
        networkManager.getSearchArticles(completion: { responseData in
            switch responseData {
            case .success(let responseData):
                self.searchNews = responseData.articles
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(responseData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }, searchText: searchedText)
    }
}

extension SearchViewModel: SearchViewModelProtocol {
    func searchBarSearchButtonClicked(searchText: String?) {
        if let searchText = searchText {
            isSearching = true
            fetchSearchArticles(searchedText: searchText)
            delegate?.reloadData()
        }
    }
    
    func searchBarCancelButtonClicked() {
        isSearching = false
        delegate?.reloadData()
    }
    
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
        delegate?.prepareSearchController()
        fetchBreakingNews()
    }
    
    func newAtIndex(index: Int) -> Article? {
        if isSearching {
            if let new = searchNews?[index] {
                return new
            }
        } else {
            if let new = breakingNews?[index] {
                return new
            }
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return (isSearching ? searchNews?.count : breakingNews?.count)  ?? .zero
    }
}
