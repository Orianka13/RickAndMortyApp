//
//  CharactersViewController.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 08.01.2023.
//

import UIKit



class CharactersViewController: UICollectionViewController {
    
    private var characters: [CharacterInfo] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fetchCharacter()
    }
    
    private func fetchCharacter() {
        let url = "https://rickandmortyapi.com/api/character"
        
        NetworkManager.shared.fetchCharacter(from: url) { [weak self] result in
            switch result {
            case .success(let info):
                self?.characters = info.results
                self?.collectionView.reloadData()
            case .failure(let error):
                print(error)
            }
        }
    }
    
    // MARK: - Navigation
    
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if let detailsVC = segue.destination as? DetailsViewController {
            guard let indexPath = collectionView.indexPathsForSelectedItems?.first else {
                print("No indexPath")
                return
            }
            detailsVC.character = characters[indexPath.item]
        }
    }
    
    
    // MARK: UICollectionViewDataSource
    
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        characters.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: CharacterViewCell.reuseIdentifier, for: indexPath) as! CharacterViewCell
        
        let character = characters[indexPath.item]
        
        cell.layer.cornerRadius = 10
        
        NetworkManager.shared.fetchImage(from: character.image) { result in
            switch result {
            case .success(let imageData):
                cell.setImage(with: imageData)
            case .failure(let error):
                print(error)
            }
        }
        
        return cell
    }
    
    
    
    
    // MARK: UICollectionViewDelegate
    
    
}

extension CharactersViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let size = CGFloat(UIScreen.main.bounds.width / 2 - 13)
        return CGSize(width: size, height: size)
    }
}
