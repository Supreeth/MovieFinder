//
//  CastTableViewCell.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit

class CastTableViewCell: UITableViewCell {

    @IBOutlet weak var actorsValueLabel: UILabel!
    @IBOutlet weak var writerValueLabel: UILabel!
    @IBOutlet weak var directorValueLabel: UILabel!

    func configureCell(with presenter:MovieDetailPresenter?) {
        actorsValueLabel.text = presenter?.movieDetail?.actors
        directorValueLabel.text = presenter?.movieDetail?.director
        writerValueLabel.text = presenter?.movieDetail?.writer
    }
}
