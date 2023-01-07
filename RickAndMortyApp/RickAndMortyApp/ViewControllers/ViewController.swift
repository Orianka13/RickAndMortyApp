//
//  ViewController.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 06.01.2023.
//

import UIKit


class ViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
    }
    
    private func fetchCharacter() {
        let url = "https://rickandmortyapi.com/api/character"
        guard let url = URL(string: url) else { return }
        
        let session = URLSession(configuration: .default)
        
        session.dataTask(with: url) { data, _, error in
            guard let data = data else {
                print(error?.localizedDescription ?? "No error description")
                return
            }
            
            let jsonDecoder = JSONDecoder()
            
            do {
                let info = try jsonDecoder.decode(Info.self, from: data)
                print(info.results)
            } catch {
                print(error.localizedDescription)
            }
            
        }.resume()
    }
}

