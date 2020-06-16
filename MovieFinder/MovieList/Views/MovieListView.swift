//
//  MovieListView.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import UIKit

protocol MovieListViewProtocol: UIView {
    var searchController: UISearchController { get }
    var delegate: MovieListViewDelegate? { get set }
    func setupView()
}

protocol MovieListViewDelegate: class {
    func didFailSearch(title:String,message: String)
    func didSelectItemAtIndexPath(indexPath: IndexPath, movieId : String)
}

class MovieListView: UIView,MovieListViewProtocol {
        
    @IBOutlet weak var collectionView: UICollectionView!
    
    private var presenter: MovieListPresenter?
    var searchController = UISearchController(searchResultsController: nil)
    weak var delegate: MovieListViewDelegate?
    private let footerView = UIActivityIndicatorView(style: .medium)
    private var collectionViewAdaptor: MovieListCollectionViewAdaptor?
    
    private func showHelpLabel(withText text: String) {
        let helpLabel = UILabel()
        helpLabel.frame.size = CGSize.zero
        helpLabel.font = UIFont.preferredFont(forTextStyle: .callout)
        helpLabel.textColor = UIColor.lightGray
        helpLabel.textAlignment = .center
        helpLabel.text = text
        helpLabel.sizeToFit()
        collectionView.backgroundView = helpLabel
    }
    
    func setupView() {
        presenter = MovieListPresenter(view: self)
        presenter?.delegate = self
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = Constants.List.search
        searchController.searchBar.returnKeyType = .done
        searchController.searchBar.delegate = self
        
        collectionViewAdaptor = MovieListCollectionViewAdaptor(presenter: presenter)
        collectionViewAdaptor?.delegate = self
        collectionView.delegate = collectionViewAdaptor
        collectionView.dataSource = collectionViewAdaptor
        collectionView.backgroundColor = .clear
        collectionView.contentInset = UIEdgeInsets(top: 23, left: 16, bottom: 10, right: 16)
        footerView.center = center
        footerView.frame.origin.y = bounds.maxY - CGFloat(Constants.List.footerViewX)
        
        showHelpLabel(withText: Constants.List.hint)
    }
}

extension MovieListView: UISearchResultsUpdating {
   
    func updateSearchResults(for searchController: UISearchController) {
        
        if let searchTerm = searchController.searchBar.text,searchTerm != presenter?.searchTerm {
            guard searchTerm.count > Constants.List.minCharsForSearch else {return}
            presenter?.search(for: searchTerm, type: .MOVIE, page: 1)
        }
    }
}

extension MovieListView : MovieListPresenterDelegate {
    func didFinishSearch() {
        collectionView.backgroundView = nil
        collectionView.reloadData()
    }
    
    func didLoadMore() {
        let offset = collectionView.contentOffset
        collectionView.reloadData()
        collectionView.setContentOffset(offset, animated: false)
        footerView.stopAnimating()
        footerView.removeFromSuperview()
    }
    
    func didFailSearch(message: String) {
        collectionView.reloadData()
        showHelpLabel(withText: Constants.List.hint)
        delegate?.didFailSearch(title: Constants.List.searchFailed, message: message)
    }
    
    func willLoadMore() {
        addSubview(footerView)
        footerView.startAnimating()
    }
}

extension MovieListView: MovieListCollectionViewAdaptorDelegate {
    func didSelectItemAt(indexPath: IndexPath) {
        searchController.dismiss(animated: true) {
            if let id = self.presenter?.movies[safe : indexPath.item]?.id {
                self.delegate?.didSelectItemAtIndexPath(indexPath: indexPath, movieId: id)
            }
        }
    }
}

extension MovieListView: UISearchBarDelegate {
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchController.dismiss(animated: true, completion: nil)
    }
}
