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
        
        NetworkManager.shared.fetchCharacter(from: url) { result in
            switch result {
            case .success(let info):
                print(info.results)
            case .failure(let error):
                print(error)
            }
        }
    }
}

