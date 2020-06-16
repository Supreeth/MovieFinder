//
//  MovieListPresenter.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

protocol MovieListPresenterDelegate: class {
    func didFinishSearch()
    func didFailSearch(message: String)
    func didLoadMore()
    func willLoadMore()
}

class MovieListPresenter {
    
    weak private var view: MovieListViewProtocol?
    weak var delegate: MovieListPresenterDelegate?
    private var service: MovieListService
    private var searchParameters = (nextPage: 1,  batchCount: 0,  totalResults: 0)
    private var loadMoreIsCalled = false
    var movies:[Movie] = []
    var searchTerm = ""
    
    init(view: MovieListViewProtocol,
         service:MovieListService = MovieListService()) {
        self.view = view
        self.service = service
    }
    
    private func loadMore(for searchTerm: String,
                          page:Int = 1) {
        
        loadMoreIsCalled = true
        
        service.search(for: searchTerm, type: .MOVIE, page: page) {  [weak self] (searchResult, error) in
            if let movies = searchResult?.movies, error == nil {
                self?.searchTerm = searchTerm
                self?.movies.append(contentsOf: movies)
                self?.searchParameters.batchCount = movies.count
                self?.searchParameters.nextPage = page + 1
                self?.searchParameters.totalResults = Int(searchResult?.totalResults ?? "0") ?? 0
                self?.loadMoreIsCalled = false
                DispatchQueue.main.async {
                    self?.delegate?.didLoadMore()
                }
            }else{
                print(error?.localizedDescription ?? "Error")
            }
        }
    }
    
    func search(for searchTerm: String,
                type: Type = .MOVIE,
                page:Int = 1){
        
        self.searchTerm = searchTerm
        service.search(for: searchTerm, type: type, page: page) { [weak self] (searchResult, error) in
            if let movies = searchResult?.movies, error == nil {
                self?.movies = movies
                self?.searchParameters.batchCount = movies.count
                self?.searchParameters.nextPage = page + 1
                self?.searchParameters.totalResults = Int(searchResult?.totalResults ?? "0") ?? 0
                DispatchQueue.main.async {
                    self?.delegate?.didFinishSearch()
                }
            }else if searchResult?.error != nil {
                self?.movies = []
                DispatchQueue.main.async {
                    self?.delegate?.didFailSearch(message: searchResult?.error ?? "Error")
                }
            }else{
                self?.movies = []
                DispatchQueue.main.async {
                    self?.delegate?.didFailSearch(message: error?.localizedDescription ?? "Error")
                }
            }
        }
        
    }
    
    func loadMore(indexPath: IndexPath) {
        guard movies.count < searchParameters.totalResults,
            self.loadMoreIsCalled == false  else
        {
            return
        }
        if indexPath.item == movies.count - 1{
            loadMore(for: searchTerm, page: searchParameters.nextPage)
            delegate?.willLoadMore()
        }
    }
}
