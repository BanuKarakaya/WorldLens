//
//  HomeViewController.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import UIKit

class HomeViewController: UIViewController{
    
    @IBOutlet weak var newsCollectionView: UICollectionView!
    
    private lazy var viewModel: HomeViewModelProtocol = HomeViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension HomeViewController: UICollectionViewDelegate {
    
}

extension HomeViewController: UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        viewModel.numberOfItems()
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: NewsCell.self, indexPath: indexPath)
        let new = viewModel.newAtIndex(index: indexPath.item)
        let cellViewModel = NewsCellViewModel(delegate: cell, new: new)
        cell.viewModel = cellViewModel
        
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func prepareUI() {
        self.title = "News"
    }
    
    func prepareCollectionView() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(cellType: NewsCell.self)
    }
    
    func reloadData() {
        newsCollectionView.reloadData()
    }
}
