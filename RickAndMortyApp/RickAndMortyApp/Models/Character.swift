//
//  Character.swift
//  RickAndMortyApp
//
//  Created by Олеся Егорова on 07.01.2023.
//


struct Info: Decodable {
    let results: [CharacterInfo]
    
    init(infoData: [String: Any]) {
        let resultsData = infoData["results"] as? [[String: Any]]
        self.results = resultsData?.compactMap{ CharacterInfo(characterData: $0) } ?? []
    }
}

struct CharacterInfo: Decodable {
    let name: String
    let species: String
    let location: Location?
    let image: String
    
    var description: String {
        """
        Имя: \(name)
        Вид: \(species)
        Локация: \(location?.name ?? "")
        """
    }
    
    init(characterData: [String: Any]) {
        let locationData = characterData["location"] as? [String: String]
        
        self.name = characterData["name"] as? String ?? ""
        self.species = characterData["species"] as? String ?? ""
        self.location = Location(locationData: locationData ?? [:])
        self.image = characterData["image"] as? String ?? ""
    }
    
}

struct Location: Decodable {
    let name: String
    
    init(locationData: [String: String]) {
        name = locationData["name"] ?? ""
    }
}

extension Info {
    static func getInfo(from value: Any) -> Info? {
        guard let infoData = value as? [String: Any] else { return nil }
        return Info(infoData: infoData)
    }
}
