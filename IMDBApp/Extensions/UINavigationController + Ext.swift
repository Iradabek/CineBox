//
//  UINavigationController + Ext.swift
//  IMDBApp
//
//  Created by Irada Bakirli on 05.07.24.
//

import UIKit

extension UINavigationController: UIGestureRecognizerDelegate {
    open override func viewDidLoad() {
        super.viewDidLoad()
        interactivePopGestureRecognizer?.delegate = self
    }
    
    public func gestureRecognizerShouldBegin(_ gestureRecognizer: UIGestureRecognizer) -> Bool {
        return viewControllers.count > 1
    }
} 
