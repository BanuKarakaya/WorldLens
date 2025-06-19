//
//  HomeViewController.swift
//  WorldLens
//
//  Created by Banu on 17.06.2025.
//

import UIKit

class HomeViewController: UIViewController {
   
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
        5
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeCell(cellType: NewsCell.self, indexPath: indexPath)
        return cell
    }
}

extension HomeViewController: HomeViewModelDelegate {
    func prepareCollectionView() {
        newsCollectionView.delegate = self
        newsCollectionView.dataSource = self
        newsCollectionView.register(cellType: NewsCell.self)
    }
    
    func reloadData() {
        newsCollectionView.reloadData()
    }
}
