//
//  DetailsViewController.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 09.01.2023.
//

import UIKit

class DetailsViewController: UIViewController {
    
    @IBOutlet private var imageView: UIImageView!
    
    @IBOutlet private var characterDescription: UILabel!
    
    var character: CharacterInfo!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupUI()
    }
    
    private func setupUI() {
        characterDescription.text = character.description
        
        NetworkManager.shared.fetchData(from: character.image) { [weak self] result in
            switch result {
            case .success(let imageData):
                self?.setImage(with: imageData)
            case .failure(let error):
                print(error)
            }
        }
    }
    
    private func setImage(with data: Data) {
        imageView.image = UIImage(data: data)
    }
}
