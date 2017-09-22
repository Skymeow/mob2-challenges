//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

struct Listing {
    // Declaring the properties we want from the JSON file
    
    let name: String?
    let pictureURL: String?
    let city: String?
    let bathrooms: Double?
    let neighborhood: String?
    init(name:String?, pictureURL: String?, city:String?, bathrooms:Double?, neighborhood:String?) {
        self.name = name
        self.pictureURL = pictureURL
        self.city = city
        self.bathrooms = bathrooms
        self.neighborhood = neighborhood
        // Essentially here what we are doing is that we are initalizing a new instance every time and we know that every instance is a new listing being made therefore we are modeling each new listing
    }
}
extension Listing: Decodable {
    enum originalLayer: String, CodingKey {
        case searchResults = "search_results"
    }
    enum firstLayer: String, CodingKey {
        case listing
    }
    enum additionalKeys: String, CodingKey {
        case name
        case pictureURL = "picture_url"
        case city
        case bathrooms
        case neighborhood
        
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: originalLayer.self)
        var unkeyedNestedContainer = try container.nestedUnkeyedContainer(forKey: .searchResults)
        //        get to firstlayer container
        var nestedContainer = try unkeyedNestedContainer.nestedContainer(keyedBy: firstLayer.self)
        var nestedContainer1 = try nestedContainer.nestedContainer(keyedBy: additionalKeys.self, forKey: .listing)
        let name = try nestedContainer1.decodeIfPresent(String.self, forKey: .name)
        let pictureURL = try nestedContainer1.decodeIfPresent(String.self, forKey: .pictureURL)
        let city = try nestedContainer1.decodeIfPresent(String.self, forKey: .city)
        let bathrooms = try nestedContainer1.decodeIfPresent(Double.self, forKey: .bathrooms)
        let neighborhood = try nestedContainer1.decodeIfPresent(String.self, forKey: .neighborhood)
        self.init(name: name, pictureURL: pictureURL, city: city, bathrooms: bathrooms, neighborhood: neighborhood)
    }
}
enum NetworkError: Error {
    case unknown
    case couldNotParseJSON
}

enum Result<T> {
    case success(T)
    case failure(NetworkError)
}

class Network {
    let session = URLSession.shared
    let url = URL(string: "https://api.airbnb.com/v2/search_results?key=915pw2pnf4h1aiguhph5gc5b2")!
    func getInfo(completion: @escaping(Result<Listing>) -> Void) {
        let request = URLRequest(url: url)
        
        
        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                
                let decoder = JSONDecoder()
                guard let info = try? decoder.decode(Listing.self, from: data) else {
                    return completion(Result.failure(NetworkError.couldNotParseJSON))
                }
                
                completion(Result.success(info))
            }
            }.resume()
        
    }
}
let result = Network()
result.getInfo() {(response) in
    print(response)
}
PlaygroundPage.current.needsIndefiniteExecution = true
