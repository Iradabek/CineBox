//
//  HomeManager.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 01.07.24.
//

import Foundation

protocol HomeManagerProtocol {
    
    func getCategoryMovies(type: MovieCategory, page: Int, complete: @escaping((Movie?, Error?)->()))
}

class HomeManager: HomeManagerProtocol {
    static let shared = HomeManager()
    
    func getCategoryMovies(type: MovieCategory, page: Int, complete: @escaping ((Movie?, Error?) -> ())) {
        var url = ""
        switch type {
        case .nowPlaying:
            url = HomeEndpoint.nowPlaying.path
        case .popular:
            url = HomeEndpoint.popular.path
        case .trending:
            url = HomeEndpoint.trending.path
        case .topRated:
            url = HomeEndpoint.topRated.path
        case .upcoming:
            url = HomeEndpoint.upcoming.path
        }
        
        URLSession.shared.fetch(type: Movie.self ,url: url + "&page=\(page)", method: .GET, headers: nil) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}
