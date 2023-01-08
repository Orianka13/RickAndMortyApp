//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 08.01.2023.
//

import Foundation

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchCharacter(from url: String, completion: @escaping(Result<Info, NetworkError>) -> Void) {
        guard let url = URL(string: url) else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { (data, _, error) in
            guard let data = data else {
                completion(.failure(.noData))
                print(error?.localizedDescription ?? "No error description")
                return
            }
            do {
                let  info = try JSONDecoder().decode(Info.self, from: data)
                DispatchQueue.main.async {
                    completion(.success(info))
                }
            } catch {
                completion(.failure(.decodingError))
            }
        }.resume()
    }
}

