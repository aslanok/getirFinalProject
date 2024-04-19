//
//  APIService.swift
//  getirFinalProject
//
//  Created by Okan Aslan on 19.04.2024.
//

import Foundation

class APIService{
    
    static let shared = APIService()
    
    func request<T: Decodable>(_ urlString : String,type : T.Type, completion: @escaping (Result<T, NetworkError>) -> Void) {
        
        guard let endpoint = URL(string: urlString) else {
            completion(.failure(NetworkError.urlError))
            return
        }
        let task = URLSession.shared.dataTask(with: endpoint) { dataResponse, urlResponse, error in
            if error == nil,let data = dataResponse, let decodedData = try? JSONDecoder().decode(type, from: data) {
                completion(.success(decodedData))
            } else {
                completion(.failure(.cannotParseData))
            }
        }
        task.resume()
    }
     
    
    
}
