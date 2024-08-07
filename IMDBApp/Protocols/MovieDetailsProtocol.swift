//
//  MovieDetailsProtocol.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 10.07.24.
//

import Foundation

protocol MovieDetailsProtocol: Codable {
    var id: Int { get }
    var posterImage: String { get }
    var titleText: String { get }
    var ratingText: String { get }
    var overViewText: String { get }
    var runtimeText: Int { get }
    var originalLanguageText: String { get }
    var releaseDateText: String { get }
    var genreItems: [String] { get }
}




