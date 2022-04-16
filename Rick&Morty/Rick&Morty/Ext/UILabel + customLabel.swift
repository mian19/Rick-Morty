//
//  UILabel + customLabel.swift
//  Rick&Morty
//
//  Created by Kyzu on 16.04.22.
//

import Foundation
import UIKit

extension UILabel {
    static func labelName(name: String) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 40.0)
        label.textAlignment = .center
        label.text = name
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
        return label
    }
    
    static func labelFullInfo(species: String, gender: String, status: String, location: String, episodes: Int) -> UILabel {
        let label = UILabel()
        label.font = UIFont.systemFont(ofSize: 30.0)
        label.numberOfLines = 5
        label.translatesAutoresizingMaskIntoConstraints = false
        label.adjustsFontSizeToFitWidth = true
       
        label.text = """
species: \(species)
gender: \(gender)
status: \(status)
location: \(location)
number of erisodes: \(episodes)
"""
        
        return label
    }
    
}
