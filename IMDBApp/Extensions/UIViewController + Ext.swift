//
//  UIViewController + Ext.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 30.06.24.
//

import UIKit

extension UIViewController {
    func showAlert(title: String, message: String) {
        let alertVC = UIAlertController(title: title, message: message, preferredStyle: .alert)
        alertVC.addAction(.init(title: "Close", style: .cancel))
        present(alertVC, animated: true)
    }
}
