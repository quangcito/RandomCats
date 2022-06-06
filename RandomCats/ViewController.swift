//
//  ViewController.swift
//  RandomCats
//
//  Created by Quang on 6/4/22.
//

import UIKit

class ViewController: UIViewController {

    
    @IBOutlet var randomCatImageView: UIImageView!
    @IBOutlet var newImageButton: UIButton!
    @IBOutlet var activityIndicator: UIActivityIndicatorView!
    
    let api = RandomCatAPI()
    
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
        
        api.randomCat { imageURL in
            guard let url = URL(string: imageURL) else {
                print("Could not get imageURL")
                return
            }
            
            if let imageData = NSData(contentsOf: url) {
                DispatchQueue.main.async {
                    self.randomCatImageView.image = UIImage(data: imageData as Data)
                    self.activityIndicator.stopAnimating()
                }
            }
        }
    }

}

