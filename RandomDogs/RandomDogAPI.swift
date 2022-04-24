//
//  RandomDogAPI.swift
//  RandomDogs
//
//  Created by Spud on 4/23/22.
//

import Foundation

class RandomDogAPI {
    
    let urlSession: URLSession = URLSession(configuration: .default)
    
    
    init() {
        
    }
    
    func randomDog(callback: @escaping (String) -> ()) {
        
        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
            print("There was a problem getting the api url")
            return
        }
        
        let datatask = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                print("There was a problem getting data")
                return
            }
            
            let randomDog = try? JSONDecoder().decode(RandomDogDataModel.self, from: data)
            
            guard let imageURL = randomDog?.message else {
                print("There was a problem getting the dog image url")
                return
            }
            
            callback(imageURL)
        }
        
        datatask.resume()
        
    }
    
}
