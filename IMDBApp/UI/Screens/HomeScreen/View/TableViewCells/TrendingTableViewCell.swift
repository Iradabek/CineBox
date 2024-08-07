//
//  TrendingTableViewCell.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 01.07.24.
//

import UIKit

class TrendingTableViewCell: UITableViewCell, MovieSelectionDelegate {
    
    weak var delegate: MovieSelectionDelegate?
    private var vm = HomeViewModel()
    private let progressView = UIProgressView(progressViewStyle: .default)
    
    private let trendingCollectionView: UICollectionView = {
        let layout = UICollectionViewFlowLayout()
        let screenSize = UIScreen.main.bounds.width
        layout.itemSize = CGSize(width: screenSize, height: 400)
        layout.scrollDirection = .horizontal
        layout.minimumLineSpacing = 0
        let trendingCollectionView = UICollectionView(frame: .zero, collectionViewLayout: layout)
        trendingCollectionView.showsHorizontalScrollIndicator = false
        trendingCollectionView.isPagingEnabled = true
        trendingCollectionView.register(TopCollectionViewCell.self, forCellWithReuseIdentifier: TopCollectionViewCell.identifier)
        return trendingCollectionView
    }()
    
    private var timer: Timer?
    private var currentIndex = 0
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        contentView.addSubview(trendingCollectionView)
        contentView.addSubview(progressView)
        
        trendingCollectionView.dataSource = self
        trendingCollectionView.delegate = self
        
        
        trendingCollectionView.snp.makeConstraints { make in
            make.edges.equalTo(contentView)
            make.height.equalTo(400)
        }
            progressView.snp.makeConstraints { make in
                make.top.equalTo(trendingCollectionView.snp.bottom).offset(12)
                make.leading.trailing.equalToSuperview().inset(16)
                make.height.equalTo(3)
            }
            
            progressView.progress = 0.0
            progressView.tintColor = .primaryYellow
            
        
        /// - Fetching  Data
        vm.fetchMovies(for: .Trending)
        vm.errorCallback = { errorMessage in
            print("Error:\(errorMessage)")
        }
        vm.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.trendingCollectionView.reloadData()
                self?.setupAutoScrollTimer()
                self?.updateProgress()
            }
        }
    }
    
    private func setupAutoScrollTimer() {
        timer = Timer.scheduledTimer(timeInterval: 5.0, target: self, selector: #selector(autoScroll), userInfo: nil, repeats: true)
    }

    @objc private func autoScroll() {
        let newIndex = (currentIndex + 1) % (vm.movie?.results?.count ?? 1)
        let indexPath = IndexPath(item: newIndex, section: 0)
        trendingCollectionView.scrollToItem(at: indexPath, at: .centeredHorizontally, animated: true)
        currentIndex = newIndex
    }
    private func updateProgress() {
        let totalItems = vm.movie?.results?.count ?? 1
        let currentPage = Int(trendingCollectionView.contentOffset.x / trendingCollectionView.frame.width)
        let progress = Float(currentPage) / Float(totalItems - 1)
        progressView.setProgress(progress, animated: true)
    }
    
    
        required init?(coder: NSCoder) {
            fatalError("init(coder:) has not been implemented")
        }
    }

    extension TrendingTableViewCell: UICollectionViewDataSource {
        func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
            vm.movie?.results?.count ?? 0
        }
        
        func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
                let cell = collectionView.dequeueReusableCell(withReuseIdentifier: TopCollectionViewCell.identifier, for: indexPath) as! TopCollectionViewCell
            if let movie = vm.movie?.results?[indexPath.item]  {
                cell.configure(movie)
                cell.delegate = self
            }
                return cell
            }
        }

    extension TrendingTableViewCell: UICollectionViewDelegate, UIScrollViewDelegate {
        func scrollViewDidScroll(_ scrollView: UIScrollView) {
            updateProgress()
        }
        
         func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
           cell.alpha = 0
           UIView.animate(withDuration: 0.7) {
               cell.alpha = 1
           }
       }
        
        func didSelectMovie(_ movie: MovieResult) {
            delegate?.didSelectMovie(movie)
        }
    }


