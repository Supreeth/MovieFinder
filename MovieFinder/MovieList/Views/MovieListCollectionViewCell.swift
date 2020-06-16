//
//  MovieListCollectionViewCell.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit
import SDWebImage

class MovieListCollectionViewCell: UICollectionViewCell {
    
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    
    var movie: Movie? {
        didSet {
            if let movie = movie {
                titleLabel.text = movie.title
            }
        }
    }
    
    func configureCell(with presenter:MovieListPresenter?) {
        imageView.contentMode = .scaleToFill
        
        let activityView = UIActivityIndicatorView()
        activityView.style = .medium
        activityView.center = imageView.center
        activityView.startAnimating()
        imageView.addSubview(activityView)
        
        imageView.sd_setImage(with: URL(string: movie?.poster ?? ""), placeholderImage: UIImage(named: "placeholder"), options: SDWebImageOptions(rawValue: 0)) { (image, error, nil, url) in
            if error != nil {
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.removeFromSuperview()
                }
            }else {
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.removeFromSuperview()
                }
            }
        }
    }
}
