//
//  MovieTitleTableViewCell.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit

class MovieTitleTableViewCell: UITableViewCell {

    @IBOutlet weak var movieImageView: UIImageView!
    @IBOutlet weak var yearLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var languageLabel: UILabel!
    var movieDetail: MovieDetail?
    
    func configureCell(with presenter:MovieDetailPresenter?) {
        
        titleLabel.text = movieDetail?.title
        yearLabel.text = movieDetail?.year
        languageLabel.text = movieDetail?.language
        movieImageView.contentMode = .scaleToFill
        
        guard presenter?.movieDetail?.poster != "N/A" else {
            movieImageView.image = UIImage(named: "placeholder")
            return
        }
        
        let activityView = UIActivityIndicatorView()
        activityView.style = .medium
        activityView.center = movieImageView.center
        activityView.startAnimating()
        movieImageView.addSubview(activityView)
        
        presenter?.getImage(url: movieDetail?.poster ?? "") { [weak self] (data, error) in
            if let data = data {
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.removeFromSuperview()
                    self?.movieImageView.image = UIImage(data: data)
                    self?.movieImageView.contentMode = .scaleToFill
                }
            }else {
                DispatchQueue.main.async {
                    activityView.stopAnimating()
                    activityView.removeFromSuperview()
                    self?.movieImageView.image = UIImage(named: "placeholder")
                }
            }
        }

    }
}
