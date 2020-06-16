//
//  MovieDetailPresenter.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation

protocol MovieDetailPresenterDelegate: class {
    func didReceiveMovieDetails()
    func didFailToFetchMovieDetails(message: String)
}

class MovieDetailPresenter {
    weak private var view: MovieDetailViewProtocol?
    private var service: MovieDetailService
    var movieDetail:MovieDetail?
    weak var delegate: MovieDetailPresenterDelegate?
    
    init(view: MovieDetailViewProtocol,
         service:MovieDetailService = MovieDetailService()) {
        self.view = view
        self.service = service
    }
    
    func getMovieDetail(with movieId: String) {
        service.getMovieDetail(with: movieId) { [weak self] (movieDetail, error) in
            if let movieDetail = movieDetail, error == nil {
                self?.movieDetail = movieDetail
                DispatchQueue.main.async {
                    self?.delegate?.didReceiveMovieDetails()
                }
            }else if movieDetail?.error != nil {
               self?.movieDetail = nil
               DispatchQueue.main.async {
                   self?.delegate?.didFailToFetchMovieDetails(message: movieDetail?.error ?? "Error")
               }
            }else{
                DispatchQueue.main.async {
                    self?.delegate?.didFailToFetchMovieDetails(message: error?.localizedDescription ?? "Error")
                }
            }
        }
    }
    
    func getImage(url: String, callback: @escaping(Data?, Error?) -> Void){
        let networkManager = NetworkManager()
        networkManager.getImage(url: url, callback: callback)
    }
}
