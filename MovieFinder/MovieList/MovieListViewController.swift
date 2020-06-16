//
//  MovieListViewController.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit

class MovieListViewController: UIViewController {
    
    private var movieListView: MovieListViewProtocol? { return self.view as? MovieListViewProtocol }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if let movieListView = movieListView {
            movieListView.setupView()
            movieListView.delegate = self
        }
        setupView()
    }
    
    private func setupView() {
        navigationController?.navigationBar.prefersLargeTitles = true
        navigationItem.title = Constants.List.title
        navigationItem.searchController = movieListView?.searchController
        navigationItem.hidesSearchBarWhenScrolling = false
        definesPresentationContext = true
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == Constants.Segue.pushToDetail {
            if let viewController = segue.destination as? MovieDetailViewController, let movieId = sender as? String {
                viewController.movieId = movieId
            }
        }
    }
}

extension MovieListViewController: MovieListViewDelegate{
    func didSelectItemAtIndexPath(indexPath: IndexPath, movieId: String) {
        performSegue(withIdentifier: Constants.Segue.pushToDetail, sender: movieId)
    }
    
    func didFailSearch(title:String,message: String) {
    }
}
