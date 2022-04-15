//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Kyzu on 14.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    private let networking = Networking()
    private var startInfo: Info? = nil
    private var listOfPersons: [Result]? = []
    private var listOfImages: [String] = []
    private var page: Int = 1
    private var infoURL: String!
    fileprivate var table: UITableView!
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        view = customView
        infoURL = "https://rickandmortyapi.com/api/character/"
    }
   
    override func viewDidLoad() {
        super.viewDidLoad()
        getPagesNumber()
        workWithTable()
   
        view.addSubview(table)
    }
    
    private func getPagesNumber() {
        networking.request(urlString: infoURL) { (result) in
            switch result {
            case .success(let requestResult):
                if self.startInfo == nil {
                    self.startInfo = requestResult.info
                }
                self.cycleForFillRows()
            case .failure(let error):
                print(error)
            case .none:
                break
            }
        }
    }
    
    private func cycleForFillRows() {
        repeat {
            
            self.infoURL = "https://rickandmortyapi.com/api/character/?page=\(self.page)"

            self.networking.request(urlString: self.infoURL) { (result) in
            switch result {
            case .success(let requestResult):
                requestResult.results.forEach{
                    self.listOfImages.append($0.image)
                }
  
                self.listOfPersons! += requestResult.results
                self.table.reloadData()
            case .failure(let error):
                print(error)
            case .none:
                break
            }
        }
            self.page += 1
        } while self.page <= self.startInfo!.pages
    }
    
    private func workWithTable() {
        table = UITableView(frame: view.bounds)
        table.dataSource = self
        table.delegate = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)
    }
    
  //  private func downloadImages(imagesNames: [String])
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {

    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return listOfPersons?.count ?? 0
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let cell = table.dequeueReusableCell(withIdentifier: CustomTableViewCell.reuseID) as! CustomTableViewCell
        
        guard let person = listOfPersons?[indexPath.row]  else {
          return cell
        }
        cell.labelName?.text = person.name
        cell.otherLabel?.text = "species: \(person.species)\ngender: \(person.gender)"
        cell.imView?.load(urlString: person.image)
       
        cell.layer.borderWidth = 2
        print(indexPath.row)

        return cell
    }
    
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
}



