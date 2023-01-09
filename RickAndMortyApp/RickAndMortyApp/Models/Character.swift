//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 07.01.2023.
//


struct Info: Decodable {
    let results: [CharacterInfo]
}

struct CharacterInfo: Decodable {
    let name: String
    let species: String
    let location: Location
    let image: String
    
    var description: String {
        """
        Имя: \(name)
        Вид: \(species)
        Локация: \(location.name)
        """
    }
}

struct Location: Decodable {
    let name: String
}
