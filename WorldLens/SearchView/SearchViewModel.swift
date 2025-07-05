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
    func categoryAt(index: Int) -> Categories?
    func viewDidLoad()
    func didSelectItemAt(index: Int)
    func didSelectItemAtForCategories(index: Int)
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
    var categoriesArticles: [Article]?
    var searchNews: [Article]?
    var isSearching = false
    private var categories: [Categories] = []
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
    
    func fetchCategoriesArticles(categoriesWord: String) {
        networkManager.getCategoriesArticles(completion: { responseData in
            switch responseData {
            case .success(let responseData):
                self.categoriesArticles = responseData.articles
                DispatchQueue.main.async {
                    self.delegate?.reloadData()
                }
                print(responseData)
                break
            case .failure(let error):
                print(error)
                break
            }
        }, categoriesWord: categoriesWord)
    }
}

struct Categories {
    let name: String
    var isSelected: Bool
}

extension SearchViewModel: SearchViewModelProtocol {
    func didSelectItemAtForCategories(index: Int) {
        var selectedType: String
        
        selectedType = categories[index].name
        for i in 0 ..< categories.count {
            categories[i].isSelected = false
        }
        categories[index].isSelected = true
        fetchCategoriesArticles(categoriesWord: selectedType)
    }
    
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
        
        selectedCell = categoriesArticles?[index]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func categoryAt(index: Int) -> Categories? {
        categories[index]
    }
    
    func numberOfItemsForCategories() -> Int {
        categories.count ?? 0
    }
    
    func viewDidLoad() {
        categories = [
            Categories.init(name: "Entertainment", isSelected: true),
            Categories.init(name: "Health", isSelected: false),
            Categories.init(name: "Science", isSelected: false),
            Categories.init(name: "Sports", isSelected: false)
        ]
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        delegate?.prepareSearchController()
        fetchCategoriesArticles(categoriesWord: "Entertainment")
    }
    
    func newAtIndex(index: Int) -> Article? {
        if isSearching {
            if let new = searchNews?[index] {
                return new
            }
        } else {
            if let new = categoriesArticles?[index] {
                return new
            }
        }
        return nil
    }
    
    func numberOfItems() -> Int {
        return (isSearching ? searchNews?.count : categoriesArticles?.count)  ?? .zero
    }
}
