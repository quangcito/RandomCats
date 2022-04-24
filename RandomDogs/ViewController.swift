//
//  ViewController.swift
//  RandomDogs
//
//  Created by Spud on 4/23/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var randomDogImageView: UIImageView!
    @IBOutlet var newImageButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let api = RandomDogAPI()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        activityIndicator.hidesWhenStopped = true
        activityIndicator.startAnimating()
        setImage()
    }

    @IBAction func didTapNewImageButton() {
        activityIndicator.startAnimating()
        setImage()
    }
    
    func setImage() {
        
        api.randomDog { imageURL in
            guard let url = URL(string: imageURL) else {
                print("frick")
                return
            }
            
            if let imageData = NSData(contentsOf: url) {
                DispatchQueue.main.async {
                    self.randomDogImageView.image = UIImage(data: imageData as Data)
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

}

