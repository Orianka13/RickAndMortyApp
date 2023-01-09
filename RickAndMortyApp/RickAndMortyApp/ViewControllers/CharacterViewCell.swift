//
//  CollectionViewCell.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 09.01.2023.
//

import UIKit

class CharacterViewCell: UICollectionViewCell {
    
    @IBOutlet private var imageView: UIImageView!
    
    static let reuseIdentifier = "cell"
    
    func setImage(with data: Data) {
        imageView.image = UIImage(data: data)
    }
}
