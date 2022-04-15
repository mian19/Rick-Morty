//
//  Networking.swift
//  Rick&Morty
//
//  Created by Kyzu on 14.04.22.
//

import Foundation
import UIKit

class Networking {
    
    func request(urlString: String, completion: @escaping (Swift.Result<RequestResult, Error>?) -> Void) {
        
        guard let url = URL(string: urlString) else { return }
        
        URLSession.shared.dataTask(with: url) {data, response, error in
            DispatchQueue.main.async {
                
                if let error = error {
                    print(error.localizedDescription)
                    completion(.failure(error))
                    return
                }
                
                guard let data = data else { return }
                
                do {
                    let decoder = JSONDecoder()
                    let gottenInfo = try decoder.decode(RequestResult.self, from: data)
                    completion(.success(gottenInfo))
                } catch {
                    print(error.localizedDescription)
                }
            }
        }.resume()
        
        return
        
    }
    
    func loadImage(urlString: String, completion: @escaping (Swift.Result<UIImage, Error>) -> Void) {
        guard let url = URL(string: urlString) else {
            return
        }
        
        URLSession.shared.dataTask(with: url) {data, _ , error in
            DispatchQueue.main.async {
                
            guard let data = data, error == nil else {
                return
            }
                    if let image = UIImage(data: data) {
                    completion(.success(image))
                    }
          
                
                
            
            
               
            }
            
        }.resume()
    }
    

//    func getPersonInfo()  {
//
//        let urlString = "https://rickandmortyapi.com/api/character/1"
//        guard let url = URL(string: urlString) else { return }
//
//        URLSession.shared.dataTask(with: url) {data, response, error in
//
//            if let error = error {
//                print(error.localizedDescription)
//            }
//
//            guard let data = data else { return }
//
//            do {
//                let decoder = JSONDecoder()
//                let gettedPerson = try decoder.decode(Person.self, from: data)
//                DispatchQueue.main.async {
//print(gettedPerson)
//                }
//            } catch {
//                print(error.localizedDescription)
//            }
//
//        }.resume()
//
//
//
//    }
}


