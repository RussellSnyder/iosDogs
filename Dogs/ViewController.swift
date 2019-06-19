//
//  ViewController.swift
//  Dogs
//
//  Created by Russell Wunder on 15.06.19.
//  Copyright © 2019 Russell Snyder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    let dogApiService = DogCEOApiService()

    @IBOutlet weak var dogImage: UIImageView!

    override func viewDidLoad() {
        print("dogs yo")
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
    }

    @IBAction func getRandomDog(_ sender: Any) {
        dogApiService.getRandomDog() { urlImageString in
            if let url = URL(string: urlImageString) {
                self.dogImage.load(url: url)
            }
        }
    }
    
}


extension UIImageView {
    func load(url: URL) {
        DispatchQueue.global().async { [weak self] in
            if let data = try? Data(contentsOf: url) {
                if let image = UIImage(data: data) {
                    DispatchQueue.main.async {
                        self?.image = image
                    }
                }
            }
        }
    }
}
