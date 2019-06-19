//
//  DogApiService.swift
//  Dogs
//
//  Created by Russell Wunder on 15.06.19.
//  Copyright © 2019 Russell Snyder. All rights reserved.
//

import Foundation

class DogCEOApiService {
    let dogApiEndpoint = "https://dog.ceo/api/"
    var dogDictionary: [String: Breed] = [:]
    
    var breedCount = 0;
    var breedPhotoSetsFetched = 0;

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
    
    func getAllDogBreeds(completionBlock: @escaping ([String]) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: URL(string: dogApiEndpoint + "breeds/list/all")!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: []) as AnyObject;
                        
                        let breedDict = (jsonResult["message"]!! as! NSDictionary)
                        
                        completionBlock(breedDict.allKeys.map{ $0 as! String })
                    } catch {
                        print("json processing error")
                    }
                }
            }
        }
        return task.resume()
    }
    
    func getDogPhotos(forBreed breed: String, completionBlock: @escaping ([URL]) -> Void) -> Void {
        let task = URLSession.shared.dataTask(with: URL(string: dogApiEndpoint + "breed/\(breed)/images")!) { (data, response, error) in
            if error != nil {
                print(error!)
            } else {
                if let urlContent = data {
                    do {
                        let jsonResult = try JSONSerialization.jsonObject(with: urlContent, options: []) as AnyObject;
                        
                        let photoStrings = (jsonResult["message"]!!) as! [String]
                        let urlEncodedStrings = photoStrings.compactMap { $0.addingPercentEncoding(withAllowedCharacters: .urlQueryAllowed) }
//                        completionBlock(photos.map { $0 as! URL })
                        completionBlock(urlEncodedStrings.map { URL(string: $0)! } )
                    } catch {
                        print("json processing error")
                    }
                }
            }
        }
        return task.resume()
    }
    
    func buildDogDictionary(completionBlock: @escaping ([String:Breed]) -> Void) {
        breedPhotoSetsFetched = 0;

        getAllDogBreeds() { breeds in
            self.breedCount = breeds.count
            for breed in breeds {
                self.getDogPhotos(forBreed: breed) { photos in
                    self.dogDictionary[breed] = Breed(photos: photos)
                    self.breedPhotoSetsFetched += 1;
                    print("\(self.breedPhotoSetsFetched) fetched: \(self.breedCount)")
                    if (self.breedPhotoSetsFetched >= self.breedCount) {
                        completionBlock(self.dogDictionary)
                    }
                }
            }
            
        }
    }
    
    func getDogDictionary() -> [String:Breed] {
            return dogDictionary
    }
}

struct Breed {
    let photos: [URL]
}
