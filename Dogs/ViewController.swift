//
//  ViewController.swift
//  Dogs
//
//  Created by Russell Wunder on 15.06.19.
//  Copyright © 2019 Russell Snyder. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    let dogApiService = DogApiService()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
    }

    @IBAction func getRandomDog(_ sender: Any) {
        dogApiService.getRandomDog();
    }
    
}

