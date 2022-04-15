//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Kyzu on 14.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    let networking = Networking()
    fileprivate var table: UITableView!
    var startInfo: Info? = nil
    var listOfPersons: [Result]!
    private let infoURL = "https://rickandmortyapi.com/api/character/"
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
       

    }
   

    override func viewDidLoad() {
        
        networking.request(urlString: infoURL) { (result) in
            switch result {
            case .success(let requestResult):
                print(requestResult)
                self.startInfo =  requestResult.info
                self.table.reloadData()
                print(self.startInfo )
            case .failure(let error):
                print(error)
            }
            
           
        }
        print(startInfo)

        
        table = UITableView(frame: view.bounds)
        table.dataSource = self
        table.delegate = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)
        view.addSubview(table)
        super.viewDidLoad()
       
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startInfo?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID) as! CustomTableViewCell
        
        var configuration = cell.defaultContentConfiguration()
        
        configuration.text = "tat"
        print(indexPath.row)
        cell.contentConfiguration = configuration
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
}



