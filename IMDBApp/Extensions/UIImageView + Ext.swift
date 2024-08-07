//
//  UIImageView + Ext.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit
import Kingfisher

extension UIImageView {
    func downloadImage(with url: String) {
        self.kf.setImage(with: URL(string: url))
    }
}
