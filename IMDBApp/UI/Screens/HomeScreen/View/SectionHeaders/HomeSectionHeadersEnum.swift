//
//  HomeSectionHeadersEnum.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit

enum HomeViewSections: CaseIterable {
    case trendingMovies
    case popularMovies
    case topRated
    case upcomingMovies
    case nowPlaying
    
    var sectionTitle: String? {
        switch self {
        case .trendingMovies:
            ""
        case .popularMovies:
            "Popular Movies"
        case .topRated:
            "Top Rated"
        case .upcomingMovies:
            "Upcoming Movies"
        case .nowPlaying:
            "Now Playing"
        
        }
    }
}
