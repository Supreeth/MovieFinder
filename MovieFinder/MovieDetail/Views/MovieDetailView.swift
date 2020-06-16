//
//  MovieDetailView.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit

protocol MovieDetailViewProtocol: UIView {
    func setupView()
    var movieId: String? {get set}
}

class MovieDetailView: UIView, MovieDetailViewProtocol {
    
    private var presenter: MovieDetailPresenter?
    @IBOutlet weak var tableView: UITableView!
    let activityView = UIActivityIndicatorView()
    
    var movieId: String? {
        didSet{
            if let id = movieId {
                presenter?.getMovieDetail(with: id)
            }
        }
    }
    
    private func showHelpLabel(withText text: String) {
        let helpLabel = UILabel()
        helpLabel.frame.size = CGSize.zero
        helpLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        helpLabel.textColor = UIColor.lightGray
        helpLabel.textAlignment = .center
        helpLabel.text = text
        helpLabel.sizeToFit()
        tableView.backgroundView = helpLabel
    }
    
    func setupView(){
        presenter = MovieDetailPresenter(view: self)
        presenter?.delegate = self
        
        tableView.tableFooterView = UIView()
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = CGFloat(Constants.Details.estimatedRowHeight)
        
        tableView.isHidden = true
        activityView.style = .large
        activityView.center = center
        activityView.startAnimating()
        addSubview(activityView)
    }
}

extension MovieDetailView: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter?.movieDetail != nil ? 3 : 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        switch indexPath.row {
        case 0:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nibs.movieTitleTableViewCell, for: indexPath) as? MovieTitleTableViewCell {
                cell.movieDetail = presenter?.movieDetail
                cell.configureCell(with: presenter)
                return cell
            }
        case 1:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nibs.synopsisTableViewCell, for: indexPath) as? SynopsisTableViewCell {
                cell.configureCell(with: presenter)
                return cell
            }
        case 2:
            if let cell = tableView.dequeueReusableCell(withIdentifier: Constants.Nibs.castTableViewCell, for: indexPath) as? CastTableViewCell {
                cell.configureCell(with: presenter)
                return cell
            }
        default:
            return UITableViewCell()
        }
        return UITableViewCell()
    }
}

extension MovieDetailView: MovieDetailPresenterDelegate {
    func didFailToFetchMovieDetails(message: String) {
        tableView.reloadData()
        showHelpLabel(withText: Constants.Generic.error)
        tableView.isHidden = false
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
    
    func didReceiveMovieDetails() {
        tableView.reloadData()
        showHelpLabel(withText: "")
        tableView.isHidden = false
        activityView.stopAnimating()
        activityView.removeFromSuperview()
    }
}
