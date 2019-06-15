//
//  DogApiService.swift
//  Dogs
//
//  Created by Russell Wunder on 15.06.19.
//  Copyright © 2019 Russell Snyder. All rights reserved.
//

import Foundation

class DogApiService {
    
    let dogApiEndpoint = "https://dog.ceo/api/"
    
    func getRandomDog(completionBlock: @escaping (String) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: URL(string: dogApiEndpoint + "breeds/image/random")!) { (data, response, error) in
                if error != nil {
                    print(error!)
                } else {
                    if let urlContent = data {
                        do {
                            let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: JSONSerialization.ReadingOptions.mutableContainers) as AnyObject
                    
                                completionBlock(jsonResult["message"]!! as! String)
                            } catch {
                                print("json processing error")
                            }
                        }
                    }
                }
        return task.resume()
    }

}
