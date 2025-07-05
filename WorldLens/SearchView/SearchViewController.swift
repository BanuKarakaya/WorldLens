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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if collectionView == searchCollectionView {
            viewModel.didSelectItemAt(index: indexPath.item)
        } else if collectionView == categoriesCollectionView {
            viewModel.didSelectItemAtForCategories(index: indexPath.item)
        }
    }
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
            let category = viewModel.categoryAt(index: indexPath.item)
            let cellViewModel = CategoriesCellViewModel(delegate: cell, categoryText: category?.name, isSelected: category!.isSelected)
            cell.viewModel = cellViewModel
            
            return cell
        }
        return UICollectionViewCell()
    }
}

extension SearchViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        if collectionView == categoriesCollectionView {
            return UIEdgeInsets(top: 0, left: 11, bottom: 0, right: 11)
        } else if collectionView == searchCollectionView {
            return UIEdgeInsets(top: 0, left: 8, bottom: 12, right: 8)
        } else {
            return UIEdgeInsets(top: 0, left: 16, bottom: 16, right: 0)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if collectionView == searchCollectionView {
            return CGSize(width: (searchCollectionView.frame.width - 33)/2, height: 210)
        } else if collectionView == categoriesCollectionView {
            return CGSize(width: 120, height: 33)
        } else {
            return CGSize(width: 120, height: 33)
        }
    }
    
}

extension SearchViewController: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarSearchButtonClicked(searchText: searchBar.text)
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        viewModel.searchBarCancelButtonClicked()
    }
}

extension SearchViewController: SearchViewModelDelegate {
    func prepareSearchController() {
        let searchController = UISearchController(searchResultsController: nil)
        searchController.hidesNavigationBarDuringPresentation = true
        searchController.obscuresBackgroundDuringPresentation = false
        navigationItem.searchController = searchController
        
        UIBarButtonItem.appearance(whenContainedInInstancesOf: [UISearchBar.self]).tintColor = .tintColor
        
        searchController.searchBar.delegate = self
    }
    
    func navigateToDetailVC(selectedCell: Article?) {
        let detailVC = UIStoryboard(name: "Main", bundle: nil).instantiateViewController(withIdentifier: "NewDetailPageViewController") as! NewDetailPageViewController
        navigationController?.pushViewController(detailVC, animated: true)
        let detailViewModel = NewsDetailPageViewModel(delegate: detailVC)
        detailVC.viewModel = detailViewModel
        detailViewModel.selectedNew = selectedCell
    }
    
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
        categoriesCollectionView.reloadData()
    }
}
