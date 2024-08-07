//
//  MovieCellProtocol.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 03.07.24.
//

import Foundation

protocol MovieCellProtocol {
    var posterImage: String { get }
    var titleText: String { get }
    var ratingText: String { get }
    var overViewText: String { get }
    // var genreItems: [String] { get }
}
