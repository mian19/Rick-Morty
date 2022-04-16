//
//  CustomCollectionViewCell.swift
//  Rick&Morty
//
//  Created by Kyzu on 14.04.22.
//

import UIKit

class CustomTableViewCell: UITableViewCell {
    static let reuseID = "Person"
    var imView: UIImageView!
    var labelName: UILabel!
    var otherLabel: UILabel!
    var imagesForPersons: [UIImage]!
    
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        
        imView = UIImageView()
        labelName = UILabel()
        otherLabel = UILabel()
        imView.translatesAutoresizingMaskIntoConstraints = false
        labelName.translatesAutoresizingMaskIntoConstraints = false
        otherLabel.translatesAutoresizingMaskIntoConstraints = false
        self.addSubview(imView)
        self.addSubview(labelName)
        self.addSubview(otherLabel)
        
        imView.layer.cornerRadius = 15
        imView.clipsToBounds = true
        imView.backgroundColor = .gray
        
        labelName.font = UIFont.boldSystemFont(ofSize: 18)
        
        otherLabel.numberOfLines = 2
        otherLabel.text = "Loading..."
        setElements()
    }
    
    private func setElements() {
        NSLayoutConstraint.activate([
            
            imView.centerYAnchor.constraint(equalTo: centerYAnchor),
            imView.heightAnchor.constraint(equalToConstant: 64),
            imView.widthAnchor.constraint(equalToConstant: 64),
            imView.leadingAnchor.constraint(equalTo: leadingAnchor, constant: 10),
            
            labelName.topAnchor.constraint(equalTo: topAnchor, constant: 10),
            labelName.heightAnchor.constraint(equalToConstant: 25),
            labelName.leadingAnchor.constraint(equalTo: imView.trailingAnchor, constant: 5),
            trailingAnchor.constraint(equalTo: labelName.trailingAnchor, constant: 5),
            
            otherLabel.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 5),
            otherLabel.leadingAnchor.constraint(equalTo: labelName.leadingAnchor),
            trailingAnchor.constraint(equalTo: otherLabel.trailingAnchor, constant: 5),
            bottomAnchor.constraint(equalTo: otherLabel.bottomAnchor, constant: 10)
        ])
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}
