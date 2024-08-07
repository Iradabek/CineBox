//
//  MovieDetailsModel.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 06.07.24.
//

// MARK: - Genre
struct Genre: Codable {
    let id: Int
    let name: String
}

// MARK: - MovieDetails
struct MovieDetails: Codable, MovieDetailsProtocol, MovieCellProtocol {
    let adult: Bool
    let backdropPath: String?
    let budget: Int
    let genres: [Genre]
    let homepage: String?
    let id: Int
    let imdbID: String?
    let originalLanguage: String
    let originalTitle: String
    let overview: String?
    let popularity: Double
    let posterPath: String?
    let releaseDate: String
    let revenue: Int
    let runtime: Int?
    let status: String
    let tagline: String?
    let title: String
    let voteAverage: Double?
    let voteCount: Int
    
    var posterImage: String {
        NetworkHelper.shared.getImagePath(url: posterPath ?? "")
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
        overview ?? ""
    }
    
    var runtimeText: Int {
        runtime ?? 0
    }
    
    var originalLanguageText: String {
        originalLanguage
    }
    
    var releaseDateText: String {
        releaseDate
    }
    
    var genreItems: [String] {
        genres.map { $0.name }
    }

    enum CodingKeys: String, CodingKey {
        case adult
        case backdropPath = "backdrop_path"
        case budget
        case genres
        case homepage
        case id
        case imdbID = "imdb_id"
        case originalLanguage = "original_language"
        case originalTitle = "original_title"
        case overview
        case popularity
        case posterPath = "poster_path"
        case releaseDate = "release_date"
        case revenue
        case runtime
        case status
        case tagline
        case title
        case voteAverage = "vote_average"
        case voteCount = "vote_count"
    }
}

// MARK: - Cast
struct Cast: Codable {
    let id: Int
    let name: String
    let character: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case character
        case profilePath = "profile_path"
    }
}

// MARK: - Credits
struct Credits: Codable {
    let cast: [Cast]
    let crew: [Crew]

    enum CodingKeys: String, CodingKey {
        case cast
        case crew
    }
}

// MARK: - Crew
struct Crew: Codable {
    let id: Int
    let name: String
    let job: String
    let profilePath: String?

    enum CodingKeys: String, CodingKey {
        case id
        case name
        case job
        case profilePath = "profile_path"
    }
}


