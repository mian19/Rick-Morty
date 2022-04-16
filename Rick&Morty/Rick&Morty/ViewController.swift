//
//  ViewController.swift
//  Rick&Morty
//
//  Created by Kyzu on 14.04.22.
//

import UIKit

class ViewController: UIViewController {
    
    private var startInfo: Info? = nil
    private var listOfPersons: [Result]? = []
    private var listOfImages: [String] = []
    private var page: Int = 1
    private var blur: UIVisualEffectView!
    private let queue = OperationQueue()
    fileprivate var table: UITableView!
    
    override func loadView() {
        let customView = UIView(frame: UIScreen.main.bounds)
        customView.backgroundColor = .white
        view = customView
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        queue.maxConcurrentOperationCount = 1
        getPageNumber()
        workWithTable()
        showLoading()
    }
    
    private func getPageNumber() {
        
        guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(self.page)") else { return }
        
        let operation = LoadOperation(session: URLSession.shared, downloadTaskURL: url, completionHandler: { result in
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
        })
        
        queue.addOperation(operation)
    }
    
    private func cycleForFillRows() {
        repeat {
            
            guard let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(self.page)") else { return }
            
            let operation = LoadOperation(session: URLSession.shared, downloadTaskURL: url, completionHandler: { result in
                switch result {
                case .success(let requestResult):
                    requestResult.results.forEach{
                        self.listOfPersons?.append($0)
                        self.listOfImages.append($0.image)
                    }
                case .failure(let error):
                    print(error)
                case .none:
                    break
                }
            })
            
            queue.addOperation(operation)
            self.page += 1
        } while self.page <= self.startInfo?.pages ?? 20
    }
    
    private func workWithTable() {
        table = UITableView(frame: view.bounds)
        table.dataSource = self
        table.delegate = self
        table.register(CustomTableViewCell.self, forCellReuseIdentifier: CustomTableViewCell.reuseID)
        view.addSubview(table)
    }
    
    private func showLoading() {
       
            let loadingView = UIView.viewForLoading()
            
            let blurEffect = UIBlurEffect(style: .systemUltraThinMaterialLight)
            self.blur = UIVisualEffectView(effect: blurEffect)
            self.blur.frame = self.view.bounds
            self.view.addSubview(self.blur)
            
            loadingView.center = self.view.center
            self.view.insertSubview(loadingView, aboveSubview: self.blur)
        DispatchQueue.main.async {
            _ = Timer.scheduledTimer(withTimeInterval: 3, repeats: false) { _ in
                self.table.reloadData()
                self.blur.removeFromSuperview()
                loadingView.removeFromSuperview()
            }
        }
    }
}

extension ViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return startInfo?.count ?? 0
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
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        100
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let storyboard = UIStoryboard(name: "PersonViewController", bundle: Bundle.main)
        let viewController = storyboard.instantiateInitialViewController() as! PersonViewController
        viewController.person = listOfPersons?[indexPath.row]
        self.present(viewController, animated: true, completion: nil)
    }
    
}



