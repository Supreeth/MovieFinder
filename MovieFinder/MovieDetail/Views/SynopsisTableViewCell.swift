//
//  SynopsisTableViewCell.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit

class SynopsisTableViewCell: UITableViewCell {

    @IBOutlet weak var votesValueLabel: UILabel!
    @IBOutlet weak var reviewsValueLabel: UILabel!
    @IBOutlet weak var scoreValueLabel: UILabel!
    @IBOutlet weak var votesHeaderLabel: UILabel!
    @IBOutlet weak var ratingHeaderLabel: UILabel!
    @IBOutlet weak var scoreHeaderLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var runtimeLabel: UILabel!
    @IBOutlet weak var ratedLabel: UILabel!
    
    func configureCell(with presenter:MovieDetailPresenter?) {
        genreLabel.text = presenter?.movieDetail?.genre
        runtimeLabel.text = presenter?.movieDetail?.runtime
        descriptionLabel.text = presenter?.movieDetail?.plot
        scoreValueLabel.text = presenter?.movieDetail?.metascore
        reviewsValueLabel.text = presenter?.movieDetail?.imdbRating
        votesValueLabel.text = presenter?.movieDetail?.votes
        ratedLabel.text = presenter?.movieDetail?.rated
    }
}
