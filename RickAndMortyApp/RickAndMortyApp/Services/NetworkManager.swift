//
//  NetworkManager.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 08.01.2023.
//

import Foundation
import Alamofire

enum NetworkError: Error {
    case invalidURL
    case noData
    case decodingError
}

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
    
    func fetchImage(from url: String?, completion: @escaping(Result<Data, NetworkError>) -> Void ) {
        guard let url = URL(string: url ?? "") else {
            completion(.failure(.invalidURL))
            return
        }
        DispatchQueue.global().async {
            guard let imageData = try? Data(contentsOf: url) else {
                completion(.failure(.noData))
                return
            }
            DispatchQueue.main.async {
                completion(.success(imageData))
            }
        }
    }
    
    func fetchCharacter(from url: String, completion: @escaping(Result<Info, AFError>) -> Void) {
        guard let url = URL(string: url) else { return }
        AF.request(url)
            .validate()
            .responseJSON { response in
                switch response.result{
                case .success(let value):
                    guard let info = Info.getInfo(from: value) else { return }
                    completion(.success(info))
                case .failure(let error):
                    completion(.failure(error))
                }
            }
        
//        URLSession.shared.dataTask(with: url) { (data, _, error) in
//            guard let data = data else {
//                completion(.failure(.noData))
//                print(error?.localizedDescription ?? "No error description")
//                return
//            }
//            do {
//                let  info = try JSONDecoder().decode(Info.self, from: data)
//                DispatchQueue.main.async {
//                    completion(.success(info))
//                }
//            } catch {
//                completion(.failure(.decodingError))
//            }
//        }.resume()
    }
}


//func fetchData(from url: String, completion: @escaping(Result<Data, AFError>) -> Void) {
//    AF.request(url)
//        .responseData { response in
//            switch response.result {
//            case .success(let imageData):
//                completion(.success(imageData))
//            case .failure(let error):
//                completion(.failure(error))
//            }
//        }
//}
