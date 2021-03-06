//
//  UIView+Ext.swift
//  News-App-CBA
//
//  Created by Nalin Aswani on 11/03/22.
//

import UIKit

extension UIView {
    func pin(to superView: UIView) { // constraints constants
        translatesAutoresizingMaskIntoConstraints = false
        topAnchor.constraint(equalTo: superView.topAnchor).isActive = true
        leadingAnchor.constraint(equalTo: superView.leadingAnchor).isActive = true
        trailingAnchor.constraint(equalTo: superView.trailingAnchor).isActive = true
        bottomAnchor.constraint(equalTo: superView.bottomAnchor).isActive = true
    }
}
