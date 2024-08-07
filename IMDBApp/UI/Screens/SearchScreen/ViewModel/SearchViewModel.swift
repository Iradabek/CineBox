//
//  SearchViewModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 02.07.24.
//

import Foundation

class SearchViewModel {
    var searchItem: Search?
    var movieItems = [SearchResult]()
    
    var filteredMovies: [SearchResult] = []
    var filterApplied: Bool = false
    
    var text = ""
    
    var successCallback: (()->())?
    var errorCallback: ((String)->())?
    
    private let userDefaultsKey = "savedMovieItems"
    var currentPage: Int = 1
    
    func getSearchItems() {
        SearchManager.shared.getSearchItems(text: text, page: currentPage) { [weak self] movie, error in
            if let error = error {
                self?.errorCallback?(error.localizedDescription)
            } else {
                self?.searchItem = movie
                if let movieItems = movie?.results, !movieItems.isEmpty {
                    self?.movieItems.append(contentsOf: movieItems)
                    self?.saveMovieItemsToUserDefaults()
                }
                self?.successCallback?()
                self?.currentPage += 1 
            }
        }
    }
    
    func pagination(index: Int) {
        guard let item = searchItem else {
            return
        }
        if (item.page) < (item.totalPages) && index == (movieItems.count - 1) {
            getSearchItems()
        }
    }
    
    func filterMovies(with keyword: String?, completion: () -> ()) {
        guard let keyword = keyword, !keyword.isEmpty else {
            /// -  Reset filteredMovies and filterApplied if keyword is nil or empty
            filteredMovies = []
            filterApplied = false
            completion()
            return
        }
        
        /// - Perform case-insensitive search by converting both title and keyword to lowercase
        filteredMovies = movieItems.filter { $0.title.range(of: keyword, options: .caseInsensitive) != nil }
        filterApplied = true
        completion()
    }
    
    private func saveMovieItemsToUserDefaults() {
        UserDefaults.standard.save(movieItems, forKey: userDefaultsKey)
    }
    
    func loadMovieItemsFromUserDefaults() {
        movieItems = UserDefaults.standard.load(forKey: userDefaultsKey) ?? []
    }
}
