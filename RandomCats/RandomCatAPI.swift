//
//  RandomCatAPI.swift
//  RandomCats
//
//  Created by Quang on 6/4/22.
//


import Foundation

class RandomCatAPI {
    
    let urlSession: URLSession = URLSession(configuration: .default)
    
    
    init() {
        
    }
    
    func randomCat(callback: @escaping (String) -> ()) {
        
        guard let url = URL(string: "https://api.thecatapi.com/v1/images/search?format=json") else {
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
            
            let catInfoList = try? JSONDecoder().decode([CatInfoDataModel].self, from: data)
            
            // Getting the first result in an array
            guard let randomCatData = catInfoList?.first else {
                print("There was a problem getting the cat data")
                return
            }
                    
            guard let imageURL = randomCatData.url else {
                print("There was a problem getting the cat image data")
                return
            }
            
            callback(imageURL)
        }
        
        datatask.resume()
        
    }
    
}
