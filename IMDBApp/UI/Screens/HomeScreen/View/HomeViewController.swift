//
//  HomeViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit
import SnapKit

class HomeViewController: UIViewController {
    
    private let vm = HomeViewModel()
    
    let navigationBarView: CustomNavigationBarView = {
        let nv = CustomNavigationBarView()
        nv.backgroundColor = .primaryYellow
        nv.configure(.init(leftTitleText: "CineBox", titleText: nil, isHideButton: true))
        return nv
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.backgroundColor = .header
        tableView.separatorStyle = .none
        
        /// - Register All TableViews
        tableView.register(TrendingTableViewCell.self, forCellReuseIdentifier: TrendingTableViewCell.identifier)
        tableView.register(PopularMoviesTableViewCell.self, forCellReuseIdentifier: PopularMoviesTableViewCell.identifier)
        tableView.register(NowPlayingTableViewCell.self, forCellReuseIdentifier: NowPlayingTableViewCell.identifier)
        tableView.register(TopRatedTableViewCell.self, forCellReuseIdentifier: TopRatedTableViewCell.identifier)
        tableView.register(UpcomingMoviesTableViewCell.self, forCellReuseIdentifier: UpcomingMoviesTableViewCell.identifier)
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(true, animated: animated)
    }
    
    func setupUI() {
        view.backgroundColor = .primaryYellow
        view.addSubview(navigationBarView)
        view.addSubview(tableView)
        
        navigationBarView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(16)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(40)
        }
        
        tableView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalToSuperview()
            make.top.equalTo(navigationBarView.snp.bottom)
        }
    }
}

extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        HomeViewSections.allCases.count
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let section = HomeViewSections.allCases[indexPath.section]
        
        switch section {
        case .trendingMovies:
            let cell = tableView.dequeueReusableCell(withIdentifier: TrendingTableViewCell.identifier, for: indexPath) as! TrendingTableViewCell
            cell.delegate = self
            return cell
        case .popularMovies:
            let cell = tableView.dequeueReusableCell(withIdentifier: PopularMoviesTableViewCell.identifier, for: indexPath) as! PopularMoviesTableViewCell
            cell.delegate = self
            return cell
        case .topRated:
            let cell = tableView.dequeueReusableCell(withIdentifier: TopRatedTableViewCell.identifier, for: indexPath) as! TopRatedTableViewCell
            cell.delegate = self
            return cell
        case .upcomingMovies:
            let cell = tableView.dequeueReusableCell(withIdentifier: UpcomingMoviesTableViewCell.identifier, for: indexPath) as! UpcomingMoviesTableViewCell
            cell.delegate = self
            return cell
        case .nowPlaying:
            let cell = tableView.dequeueReusableCell(withIdentifier: NowPlayingTableViewCell.identifier, for: indexPath) as! NowPlayingTableViewCell
            cell.delegate = self
            return cell
        }
    }
}

extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let sectionType = HomeViewSections.allCases[section]
        switch sectionType {
        case .popularMovies, .nowPlaying, .topRated, .upcomingMovies:
            return HomeSectionHeaderView(title: sectionType.sectionTitle)
        default:
            return nil
        }
    }
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        let sectionHeight = HomeViewSections.allCases[section]
        switch sectionHeight {
        case .trendingMovies:
            return 0
        default:
            return 40
        }
    }
}

extension HomeViewController: MovieSelectionDelegate {
    func didSelectMovie(_ movie: MovieResult) {
        let detailsVC = MovieDetailsViewController()
        detailsVC.configure(with: movie.id ?? 0)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

