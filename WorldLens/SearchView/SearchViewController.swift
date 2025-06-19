//
//  SearchViewController.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var searchCollectionView: UICollectionView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    private lazy var viewModel: SearchViewModelProtocol = SearchViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension SearchViewController: UICollectionViewDelegate {
    
}

extension SearchViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        if collectionView == searchCollectionView {
            return viewModel.numberOfItems()
        } else if collectionView == categoriesCollectionView {
            return viewModel.numberOfItemsForCategories()
        }
        return 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if collectionView == searchCollectionView {
            let cell = collectionView.dequeCell(cellType: SearchNewsCell.self, indexPath: indexPath)
            let new = viewModel.newAtIndex(index: indexPath.item)
            let cellViewModel = SearchCellViewModel(delegate: cell, new: new)
            cell.viewModel = cellViewModel
            
            return cell
        } else if collectionView == categoriesCollectionView {
            let cell = collectionView.dequeCell(cellType: CategoriesCell.self, indexPath: indexPath)
            let category = viewModel.categoryAtIndex(index: indexPath.item)
            let cellViewModel = CategoriesCellViewModel(delegate: cell, category: category)
            cell.viewModel = cellViewModel
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoriesCollectionView {
            return UIEdgeInsets(top: 0, left: 12, bottom: 0, right: 12)
        } else if collectionView == searchCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
        }
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func prepareUI() {
        searchCollectionView.showsVerticalScrollIndicator = false
        categoriesCollectionView.showsHorizontalScrollIndicator = false
        self.title = "Categories"
    }
    
    func prepareCollectionView() {
        searchCollectionView.dataSource = self
        categoriesCollectionView.dataSource = self
        searchCollectionView.delegate = self
        categoriesCollectionView.delegate = self
        searchCollectionView.register(cellType: SearchNewsCell.self)
        categoriesCollectionView.register(cellType: CategoriesCell.self)
    }
    
    func reloadData() {
        searchCollectionView.reloadData()
    }
}
