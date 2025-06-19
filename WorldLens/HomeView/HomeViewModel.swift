//
//  HomeViewModel.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import Foundation

protocol HomeViewModelProtocol {
    func viewDidLoad()
    func newAtIndex(index: Int) -> Article?
    func numberOfItems() -> Int
    func didSelectItemAt(index: Int)
}

protocol HomeViewModelDelegate: AnyObject {
    func prepareCollectionView()
    func reloadData()
    func prepareUI()
    func navigateToDetailVC(selectedCell: Article?)
}

final class HomeViewModel {
    weak var delegate: HomeViewModelDelegate?
    var articles: [Article]?
    private let networkManager: NetworkManagerInterface
    
    init(delegate: HomeViewModelDelegate?, networkManager: NetworkManagerInterface = NetworkManager.shared) {
        self.delegate = delegate
        self.networkManager = networkManager
    }
    
    func fetchArticles() {
        networkManager.getArticles { responseData in
            switch responseData {
            case .success(let responseData):
                self.articles = responseData.articles
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

extension HomeViewModel: HomeViewModelProtocol {
    func didSelectItemAt(index: Int) {
        var selectedCell: Article?
        
        selectedCell = articles?[index]
        delegate?.navigateToDetailVC(selectedCell: selectedCell)
    }
    
    func numberOfItems() -> Int {
        return articles?.count ?? 0
    }
    
    func newAtIndex(index: Int) -> Article? {
        if let new = articles?[index] {
            return new
        }
        return nil
    }
    
    func viewDidLoad() {
        delegate?.prepareCollectionView()
        delegate?.prepareUI()
        fetchArticles()
    }
}
