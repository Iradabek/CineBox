//
//  SearchModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 02.07.24.
//

import Foundation

// MARK: - Welcome
struct Search: Codable {
    let page: Int
    let results: [SearchResult]
    let totalPages, totalResults: Int

    enum CodingKeys: String, CodingKey {
        case page, results
        case totalPages = "total_pages"
        case totalResults = "total_results"
    }
}

// MARK: - Result
struct SearchResult: Codable, MovieCellProtocol {
    let adult: Bool
    let backdropPath: String
    let genreIDS: [Int]
    let id: Int
    let originalLanguage, originalTitle, overview: String
    let popularity: Double
    let posterPath, releaseDate, title: String
    let video: Bool
    let voteAverage: Double?
    let voteCount: Int

    var posterImage: String {
        NetworkHelper.shared.getImagePath(url: posterPath)
    }
    
    var titleText: String {
        title
    }
    
    var ratingText: String {
        if let voteAverage = voteAverage {
            return "\(String(format: "%.1f", voteAverage)) / 10 IMDB"
        }
        return ""
    }
    
    var overViewText: String {
        overview
    }
        enum CodingKeys: String, CodingKey {
            case adult
            case backdropPath = "backdrop_path"
            case genreIDS = "genre_ids"
            case id
            case originalLanguage = "original_language"
            case originalTitle = "original_title"
            case overview, popularity
            case posterPath = "poster_path"
            case releaseDate = "release_date"
            case title, video
            case voteAverage = "vote_average"
            case voteCount = "vote_count"
        }
    }
