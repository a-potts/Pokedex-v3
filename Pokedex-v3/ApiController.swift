//
//  ApiController.swift
//  Pokedex-v3
//
//  Created by Austin Potts on 9/7/19.
//  Copyright © 2019 Lambda School. All rights reserved.
//

import Foundation

class PokemonController {
    
    let baseURL = URL(string: "https://pokeapi.co//api/v2/pokemon/")!
    
    func getPokemon(searchTerm: String, completion: @escaping (Result<Pokemon, Error>)-> Void){
        
        //Append search Term to url
        let requestURL = baseURL.appendingPathComponent(searchTerm)
        
        
        URLSession.shared.dataTask(with: requestURL) { (data, _, error) in
           
           //Error Handling
            if let error = error {
                print("Error getting pokemon: \(error)")
                completion(.failure(error))
                return
            }
            guard let data = data else {
                print("Error getting data from data task: ")
                completion(.failure(NSError()))
                return
            }
            
            
            //Decode the JSON data Pokemon
            do {
                let pokemon = try JSONDecoder().decode(Pokemon.self, from: data)
                print(pokemon)
                completion(.success(pokemon))
            } catch {
                print("Error decoding data to type Pokemon: \(error)")
                completion(.failure(error))
                
            }
            
        }.resume()
        
    }
    
}