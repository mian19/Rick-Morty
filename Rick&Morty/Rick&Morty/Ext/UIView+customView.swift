//
//  UIView+customView.swift
//  Rick&Morty
//
//  Created by Kyzu on 16.04.22.
//

import Foundation
import UIKit

extension UIView {
    static func viewForLoading() -> UIView {
        let view = UIView()
        let label = UILabel()
        let spinner = UIActivityIndicatorView()
        
        view.frame.size = CGSize(width: UIScreen.main.bounds.width * 0.7, height: UIScreen.main.bounds.height * 0.3)
        view.backgroundColor = .lightGray
        view.layer.cornerRadius = 10
        view.clipsToBounds = true
        
        spinner.frame.size = CGSize(width: 40, height: 40)
        spinner.center = view.center
        spinner.transform = CGAffineTransform(scaleX: 3, y: 3)
        
        label.text = "Loading data from server..."
        label.frame = CGRect(x: view.bounds.minX, y: view.bounds.maxY - 50, width: view.bounds.width, height: view.bounds.height * 0.2)
        label.textAlignment = .center
        label.textColor = .white
        label.font = UIFont.systemFont(ofSize: 20.0)
      
        spinner.startAnimating()
        view.addSubview(label)
        view.addSubview(spinner)
        
        return view
    }
    
}
