//
//  MovieListCollectionViewAdaptor.swift
//  MovieFinder
//
//  Created by Supreethd on 15/06/20.
//  Copyright © 2020 Supreethd. All rights reserved.
//

import Foundation
import UIKit

protocol MovieListCollectionViewAdaptorDelegate: class {
    func didSelectItemAt( indexPath: IndexPath)
}

class MovieListCollectionViewAdaptor: NSObject, UICollectionViewDelegateFlowLayout, UICollectionViewDataSource {
    
    private var presenter: MovieListPresenter?
    weak var delegate: MovieListCollectionViewAdaptorDelegate?
    
    init(presenter: MovieListPresenter?) {
        self.presenter = presenter
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter?.movies.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        if let cell = collectionView.dequeueReusableCell(withReuseIdentifier: Constants.Nibs.listCollectionCell, for: indexPath as IndexPath) as? MovieListCollectionViewCell {
            cell.movie = presenter?.movies[safe : indexPath.item]
            cell.configureCell(with: presenter)
            return cell
        }
        return UICollectionViewCell()
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        presenter?.loadMore(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath){
        delegate?.didSelectItemAt(indexPath: indexPath)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let padding: CGFloat =  CGFloat(Constants.List.cellPadding)
        let collectionViewSize = collectionView.frame.size.width - padding

        return CGSize(width: collectionViewSize/2, height: CGFloat(Constants.List.cellHeight))
    }
}
