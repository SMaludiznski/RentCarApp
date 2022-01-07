//
//  NetworkingManager.swift
//  RentCarApp
//
//  Created by Sebastian Maludziński on 06/01/2022.
//

import Foundation


protocol NetworkManagerProtocol {
    func downloadData(from url: String, completionHandler: @escaping (Result<Data, Error>) -> ())
}

final class NetworkManager: NetworkManagerProtocol {
    
    func downloadData(from url: String, completionHandler: @escaping (Result<Data, Error>) -> ()) {
        
        guard let url = URL(string: url) else {
            completionHandler(.failure(NetworkingErrors.wrongURL))
            return
        }
        
        let task = URLSession.shared.dataTask(with: url) { (data, response, error) in
            
            if error != nil {
                completionHandler(.failure(NetworkingErrors.downloadingError))
                return
            }
            
            guard let data = data else {
                completionHandler(.failure(NetworkingErrors.downloadingError))
                return
            }
            
            guard let response = response as? HTTPURLResponse,
                  response.statusCode >= 200 && response.statusCode < 300 else {
                      completionHandler(.failure(NetworkingErrors.wrongServerResponse))
                      return
                  }
            
            completionHandler(.success(data))
        }
        task.resume()
    }
}
