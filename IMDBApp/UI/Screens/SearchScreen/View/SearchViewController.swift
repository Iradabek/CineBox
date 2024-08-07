//
//  SearchViewController.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 02.07.24.
//

import UIKit
import SnapKit

class SearchViewController: UIViewController,UISearchResultsUpdating {
    
    private let vm = SearchViewModel()
    let searchController = UISearchController()
      
    private let tableView: UITableView = {
        let tableView = UITableView(frame: .zero, style: .grouped)
        tableView.separatorStyle = .none
        tableView.register(SearchTableViewCell.self, forCellReuseIdentifier: SearchTableViewCell.identifier)
        tableView.register(SearchEmptyTableViewCell.self, forCellReuseIdentifier: SearchEmptyTableViewCell.identifier)
        tableView.keyboardDismissMode = .onDrag
        return tableView
    }()
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .primarySurface
        view.addSubview(tableView)
        tableView.dataSource = self
        tableView.delegate = self
        setupViewModel()
        title = "Search"
        
        searchController.searchResultsUpdater = self
        searchController.obscuresBackgroundDuringPresentation = false
        searchController.searchBar.placeholder = "Search Movies"
        navigationItem.searchController = searchController
        definesPresentationContext = true
        searchController.hidesNavigationBarDuringPresentation = false
        
        tableView.snp.makeConstraints { make in
            make.edges.equalToSuperview()
        }
        
        vm.loadMovieItemsFromUserDefaults()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(false, animated: animated)
    }
    
    func updateSearchResults(for searchController: UISearchController) {
        guard let text = searchController.searchBar.text else {
            return
        }
        vm.filterMovies(with: text) {
            DispatchQueue.main.async {
                self.tableView.performBatchUpdates({
                    self.tableView.reloadSections(IndexSet(integer: 0), with: .fade)
                }, completion: nil)
            }
        }
    }
    
    fileprivate func setupViewModel() {
        vm.getSearchItems()
        vm.errorCallback = { errorMessage in
            print(errorMessage)
        }
        vm.successCallback = { [weak self] in
            DispatchQueue.main.async {
                self?.tableView.reloadData()
            }
        }
     }
  }

extension SearchViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if vm.filterApplied {
            return vm.filteredMovies.count == 0 ? 1 : vm.filteredMovies.count
        } else {
            return vm.movieItems.count
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: SearchTableViewCell.identifier, for: indexPath) as! SearchTableViewCell
        
        if vm.filterApplied {
            if vm.filteredMovies.count == 0 {
                let emptyCell = tableView.dequeueReusableCell(withIdentifier: SearchEmptyTableViewCell.identifier, for: indexPath) as! SearchEmptyTableViewCell
                emptyCell.configure(.init(title: "\"\(searchController.searchBar.text ?? "")\" NOT FOUNDED"))
                return emptyCell
                
            } else {
                cell.configure(vm.filteredMovies[indexPath.row])
            }
        } else {
        cell.configure(vm.movieItems[indexPath.row])
        }
        return cell
    }
}

extension SearchViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        
        let selectedMovie = vm.filterApplied ? vm.filteredMovies[indexPath.row] : vm.movieItems[indexPath.row]
                let detailsVC = MovieDetailsViewController()
                detailsVC.configure(with: selectedMovie.id)
                navigationController?.pushViewController(detailsVC, animated: true)
    }

}

