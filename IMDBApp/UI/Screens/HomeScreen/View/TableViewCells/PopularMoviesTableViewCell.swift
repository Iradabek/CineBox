//
//  PopularMoviesTableViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit

class PopularMoviesTableViewCell: UITableViewCell {
    
        weak var delegate: MovieSelectionDelegate?
        private var vm = HomeViewModel()
     
        private let popularCollectionView: UICollectionView = {
            let layout = UICollectionViewFlowLayout()
            let screenSize = UIScreen.main.bounds.width
            layout.itemSize = CGSize(width: (screenSize / 2 - 56)  , height: 260)
            layout.scrollDirection = .horizontal
            layout.minimumLineSpacing = 16
            let popularCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
            popularCollectionView.contentInset = .init(top: 16, left: 16, bottom: 16, right: 16)
            popularCollectionView.showsHorizontalScrollIndicator = false
            popularCollectionView.register(CategoriesCollectionViewCell.self, forCellWithReuseIdentifier: CategoriesCollectionViewCell.identifier)
            return popularCollectionView
        }()

        
        override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
            super.init(style: style, reuseIdentifier: reuseIdentifier)
            contentView.addSubview(popularCollectionView)
            popularCollectionView.dataSource = self
            popularCollectionView.delegate = self
            
            popularCollectionView.snp.makeConstraints { make in
                make.edges.equalTo(contentView)
                make.height.equalTo(280)
            }
            
            /// - Fetching  Data
            vm.fetchMovies(for: .Popular)
            vm.errorCallback = { errorMessage in
                print("Error:\(errorMessage)")
            }
            vm.successCallback = { [weak self] in
                DispatchQueue.main.async {
                    self?.popularCollectionView.reloadData()
                }
            }
        }
        
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    extension PopularMoviesTableViewCell: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            vm.movie?.results?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CategoriesCollectionViewCell.identifier, for: indexPath) as! CategoriesCollectionViewCell
            if let movie = vm.movie?.results?[indexPath.item]  {
                cell.configure(movie)
            }
            cell.addShadow()
                return cell
            }
        }

extension PopularMoviesTableViewCell: UICollectionViewDelegate {
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        if let movie = vm.movie?.results?[indexPath.item] {
            delegate?.didSelectMovie(movie)
        }
        collectionView.deselectItem(at: indexPath, animated: true)
    }
}
