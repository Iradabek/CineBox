//
//  WatchListViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 13.07.24.
//

import UIKit

class WatchListViewController: UIViewController {
    
    private let vm = WatchListViewModel()
    
    let navigationBarView: CustomNavigationBarView = {
        let nv = CustomNavigationBarView()
        nv.configure(.init(leftTitleText: nil, titleText: "WatchList", isHideButton: true ))
        nv.backgroundColor = .primarySurface
        return nv
    }()
    
    private let verticalStackView: UIStackView = {
        let sv = UIStackView()
        sv.axis = .vertical
        return sv
    }()
    
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(WatchListTableViewCell.self, forCellReuseIdentifier: WatchListTableViewCell.identifier)
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    private var emptyView: EmptyWatchListView = {
        let emptyView = EmptyWatchListView()
        emptyView.isHidden = true
        return emptyView
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.dataSource = self
        tableView.delegate = self
        setupUI()
    }
        
    func setupUI() {
        view.backgroundColor = .primarySurface
        view.addSubview(navigationBarView)
        view.addSubview(verticalStackView)
        [tableView, emptyView].forEach(verticalStackView.addArrangedSubview)
        
        navigationBarView.snp.makeConstraints { make in
            make.trailing.leading.equalToSuperview().inset(4)
            make.top.equalTo(view.safeAreaLayoutGuide)
            make.height.equalTo(48)
        }
        
        verticalStackView.snp.makeConstraints { make in
            make.trailing.leading.bottom.equalTo(view.safeAreaLayoutGuide)
            make.top.equalTo(navigationBarView.snp.bottom)
        }
        
        vm.loadWatchlist()
        vm.watchlistUpdated = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
                if self?.vm.movieItems.isEmpty == true {
                    self?.tableView.isHidden = true
                    self?.emptyView.isHidden = false
                } else {
                    self?.tableView.isHidden = false
                    self?.emptyView.isHidden = true
                }
            }
        }
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        vm.loadWatchlist()
    }
  }

extension WatchListViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return vm.movieItems.isEmpty ? 0 : vm.movieItems.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = tableView.dequeueReusableCell(withIdentifier: WatchListTableViewCell.identifier, for: indexPath) as! WatchListTableViewCell
            cell.configure(vm.movieItems[indexPath.row] as  MovieCellProtocol  )
            return cell
        }
    }

extension WatchListViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedMovie = vm.movieItems[indexPath.row]
        let detailsVC = MovieDetailsViewController()
        detailsVC.configure(with: selectedMovie.id)
        navigationController?.pushViewController(detailsVC, animated: true)
    }
}

