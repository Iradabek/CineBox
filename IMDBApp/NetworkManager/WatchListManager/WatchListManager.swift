//
//  WatchListManager.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 13.07.24.
//

import Foundation

class WatchlistManager {
    static let shared = WatchlistManager()
    
    private(set) var watchlistMovies: [MovieDetails] = []
    
    private init() {
        loadWatchlist()
    }
    
    func addMovieToWatchlist(_ movie: MovieDetails) {
        if !watchlistMovies.contains(where: { $0.id == movie.id }) {
            watchlistMovies.append(movie)
            saveWatchlist()
        }
    }
    
    func removeMovieFromWatchlist(_ movie: MovieDetails) {
        watchlistMovies.removeAll { $0.id == movie.id }
        saveWatchlist()
    }
    
    func isMovieInWatchlist(_ movie: MovieDetails) -> Bool {
        return watchlistMovies.contains(where: { $0.id == movie.id })
    }
    
    private func saveWatchlist() {
        let encoder = JSONEncoder()
        if let data = try? encoder.encode(watchlistMovies) {
            UserDefaults.standard.set(data, forKey: "watchlistMovies")
        }
    }
    
    private func loadWatchlist() {
        let decoder = JSONDecoder()
        if let data = UserDefaults.standard.data(forKey: "watchlistMovies"),
           let movies = try? decoder.decode([MovieDetails].self, from: data) {
            watchlistMovies = movies
        }
    }
}

