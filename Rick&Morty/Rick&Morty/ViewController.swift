//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Kyzu on 14.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    fileprivate var table: UITableView!

    override func viewDidLoad() {
        table = UITableView(frame: view.bounds)
        table.dataSource = self
        table.delegate = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: "MyCell")
        view.addSubview(table)
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 826
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        var cell = CustomTableViewCell(style: .default, reuseIdentifier: CustomTableViewCell.reuseID)
        
        var configuration = cell.defaultContentConfiguration()
        configuration.text = "Row \(indexPath.row)"
        print(indexPath.row)
        cell.contentConfiguration = configuration
        return cell
    }
    
    
}

