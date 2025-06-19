//
//  SearchNewsCell.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import UIKit

class SearchNewsCell: UICollectionViewCell {

    @IBOutlet weak var newsPhoto: UIImageView!
    @IBOutlet weak var newsTitle: UILabel!
    @IBOutlet weak var newsContent: UILabel!
    
    var viewModel: SearchCellViewModelProtocol! {
        didSet {
            viewModel.awakeFromNib()
            viewModel.load()
        }
    }
}

extension SearchNewsCell: SearchCellViewModelDelegate {
    func prepareUI() {
        self.layer.cornerRadius = 16
        newsContent.numberOfLines = 0
        newsPhoto.layer.cornerRadius = 10
        self.layer.borderWidth = 0.5
        self.layer.borderColor = UIColor(red: 174/255.0, green: 165/255.0, blue: 164/255.0, alpha: 0.25).cgColor
    }
    
    func configureCell(new: Article?) {
        newsTitle.text = new?.title
        newsContent.text = new?.description
        prepareBannerImage(with: new?.urlToImage)
    }
    
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            newsPhoto.sd_setImage(with: url)
        }
    }
}
