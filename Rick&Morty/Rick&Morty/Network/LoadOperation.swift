//
//  DownloadOperation.swift
//  Rick&Morty
//
//  Created by Kyzu on 16.04.22.
//

import Foundation


class LoadOperation : Operation {
    
    private var task : URLSessionDataTask!
    enum OperationState : Int {
        case ready
        case executing
        case finished
    }
    
    private var state : OperationState = .ready {
        willSet {
            self.willChangeValue(forKey: "isExecuting")
            self.willChangeValue(forKey: "isFinished")
        }
        
        didSet {
            self.didChangeValue(forKey: "isExecuting")
            self.didChangeValue(forKey: "isFinished")
        }
    }
    
    override var isReady: Bool { return state == .ready }
    override var isExecuting: Bool { return state == .executing }
    override var isFinished: Bool { return state == .finished }
  
    init(session: URLSession, downloadTaskURL: URL, completionHandler: @escaping (Swift.Result<RequestResult, Error>?) -> Void) {
        super.init()
        
        task = session.dataTask(with: downloadTaskURL, completionHandler: { [weak self] (data, response, error) in
            if let error = error {
                print(error.localizedDescription)
                completionHandler(.failure(error))
                return
            }
            
            guard let data = data else { return }
            
            do {
                let decoder = JSONDecoder()
                let gottenInfo = try decoder.decode(RequestResult.self, from: data)
                completionHandler(.success(gottenInfo))
            } catch {
                print(error.localizedDescription)
            }
            self?.state = .finished
        })
    }

    override func start() {
      /*
      if the operation or queue got cancelled even
      before the operation has started, set the
      operation state to finished and return
      */
      if(self.isCancelled) {
          state = .finished
          return
      }
      
      // set the state to executing
      state = .executing
      // start the downloading
      self.task.resume()
  }

  override func cancel() {
      super.cancel()
    
      // cancel the downloading
      self.task.cancel()
  }
}
