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
        
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?format=json") else {
            print("There was a problem getting the api url")
            return
        }
        
        
//        guard let url = URL(string: "https://dog.ceo/api/breeds/image/random") else {
//            print("There was a problem getting the api url")
//            return
//        }
        
        let datatask = urlSession.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            guard let data = data else {
                print("There was a problem getting data")
                return
            }
            
            let rootData = try? JSONDecoder().decode(RandomDogRootDataModel.self, from: data)
            
            guard let randomDogData = rootData?.all else {
                print("There was a problem getting the dog data")
                return
            }
                    
//            guard let imageURL = randomDogData.url else {
//                print("There was a problem getting the dog image data")
//                return
//            }
            
            let imageURL = randomDogData.first?.url
            
            callback(imageURL!)
        }
        
        datatask.resume()
        
    }
    
}
