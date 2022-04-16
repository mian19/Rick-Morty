//
//  PersonViewController.swift
//  Rick&Morty
//
//  Created by Kyzu on 16.04.22.
//На экране детальной информации о персонаже должно отображаться имя, раса, пол, статус, аватарка, последнее известное местоположение, кол-во эпизодов, в которых упоминался данный персонаж.

import UIKit

class PersonViewController: UIViewController {

    var person: Result!
    
    private var imageView: UIImageView!
    private var labelName: UILabel!
    private var labelFullInfo: UILabel!
    private var numberEpisodes: Int!

    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = UIColor(red: 1, green: 0.8902, blue: 0.4588, alpha: 1.0)
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        numberEpisodes = person.episode.count
        
        imageView = UIImageView()
        imageView.load(urlString: person.image)
        imageView.translatesAutoresizingMaskIntoConstraints = false
        labelName = UILabel.labelName(name: person.name)
        
        labelFullInfo = UILabel.labelFullInfo(species: person.species, gender: person.gender, status: person.status, location: person.location.name, episodes: numberEpisodes)
        
        view.addSubview(imageView)
        view.addSubview(labelName)
        view.addSubview(labelFullInfo)
        
        setElements()
    
    }
    
    private func setElements() {
        NSLayoutConstraint.activate([
        
            imageView.widthAnchor.constraint(equalToConstant: 200),
            imageView.heightAnchor.constraint(equalToConstant: 200),
            imageView.topAnchor.constraint(equalTo: view.topAnchor, constant: 25),
            imageView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            
            labelName.heightAnchor.constraint(equalToConstant: 50),
            labelName.widthAnchor.constraint(equalTo: view.widthAnchor),
            labelName.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            labelName.topAnchor.constraint(equalTo: imageView.bottomAnchor, constant: 25),
            
            labelFullInfo.topAnchor.constraint(equalTo: labelName.bottomAnchor, constant: 50),
            labelFullInfo.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            view.trailingAnchor.constraint(equalTo: labelFullInfo.trailingAnchor, constant: 5)
            
            
        
        ])
    }
    


}
