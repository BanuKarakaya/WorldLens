//
//  NewDetailPageViewController.swift
//  WorldLens
//
//  Created by Banu on 19.06.2025.
//

import UIKit

class NewDetailPageViewController: UIViewController {

    @IBOutlet weak var newPhoto: UIImageView!
    @IBOutlet weak var newTitle: UILabel!
    @IBOutlet weak var newContent: UILabel!
    @IBOutlet weak var forMore: UITextView!
    
    lazy var viewModel:  NewsDetailPageViewModelProtocol = NewsDetailPageViewModel(delegate: self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.viewDidLoad()
    }
}

extension NewDetailPageViewController: NewsDetailPageViewModelDelegate {
    func prepareUI() {
        newPhoto.layer.cornerRadius = 12
        forMore.dataDetectorTypes = .link
        forMore.isEditable = false
        forMore.isScrollEnabled = false
    }
    
    func prepareBannerImage(with urlString: String?) {
        if let imageUrlString = urlString, let url = URL(string:imageUrlString){
            newPhoto.sd_setImage(with: url)
        }
    }
    
    func configure(selectedNew: Article) {
        prepareBannerImage(with: selectedNew.urlToImage)
        newTitle.text = selectedNew.title
        newContent.text = selectedNew.content
        forMore.text = "For more: \(selectedNew.url ?? "")"
    }
}
