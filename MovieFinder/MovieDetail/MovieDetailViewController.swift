//
//  MovieDetailViewController.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit

class MovieDetailViewController: UIViewController {
    
    private var movieDetailView: MovieDetailViewProtocol? { return self.view as? MovieDetailViewProtocol }
    
    var movieId: String? {
        didSet{
            if let id = movieId {
                movieDetailView?.movieId = id
            }
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if let movieDetailView = movieDetailView {
            movieDetailView.setupView()
        }
        
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.Details.title
        
        
    }
}
