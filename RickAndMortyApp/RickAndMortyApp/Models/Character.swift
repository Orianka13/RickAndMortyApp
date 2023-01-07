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
}

struct Location: Decodable {
    let name: String
}
