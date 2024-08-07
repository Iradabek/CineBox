//
//  MovieDetailsManager.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 06.07.24.
//

import Foundation

protocol MovieDetailsManagerProtocol {
    func getMovieDetails(id: Int, complete: @escaping ((MovieDetails?, Error?) -> ()))
}

class MovieDetailsManager {
    static let shared = MovieDetailsManager()
    private init() {}
    
    func getMovieDetails(id: Int, complete: @escaping ((MovieDetails?, Error?) -> ())) {
        URLSession.shared.fetch(type: MovieDetails.self,
                                url: "https://api.themoviedb.org/3/movie/\(id)?api_key=e2253416fac0cd2476291eb33c92beb7",
                                method: .GET, headers: nil) { response in
            switch response {
            case .success(let data):
                complete(data, nil)
            case .failure(let error):
                complete(nil, error)
            }
        }
    }
}









