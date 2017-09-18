//: Playground - noun: a place where people can play

import UIKit
import Foundation
import PlaygroundSupport

struct SearchResult: Decodable {
    let searchResult: [Listing]
    
    enum searchKey: String, CodingKey {
        case searchResult = "search_results"
    }
    init(searchResult: [Listing]) {
        self.searchResult = searchResult
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: searchKey.self)
        let searchResult = try container.decode([Listing].self, forKey: .searchResult)
        self.init(searchResult: searchResult)
    }
}

struct Listing {
    let bedrooms: Double
    let city: String
    let id: Int
    
    let primaryHost: PrimaryHost
    
//    init(bedrooms: Double, city: String, id: Int, primaryHost: PrimaryHost){
//        self.bedrooms = bedrooms
//        self.city = city
//        self.id = id
//        self.primaryHost = primaryHost
//    }
}

struct PrimaryHost: Decodable {
    let firstName: String
    let pictureUrl: String
    
    enum HostKey: String, CodingKey {
        case firstName = "first_name"
        case pictureUrl = "picture_url"
    }
    
    init(firstName: String, pictureUrl: String?) {
        self.firstName = firstName
//        nil coalesion unwrap the optional object , if nil then "", or else umwrap
        self.pictureUrl = pictureUrl ?? ""
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: HostKey.self)
        let firstName = try container.decode(String.self, forKey: .firstName)
        let pictureUrl = try container.decode(String.self, forKey: .pictureUrl)
        self.init(firstName: firstName, pictureUrl: pictureUrl)
    }
    
}

//serialize data
extension Listing: Decodable {

    enum TopLevelKeys: String, CodingKey {
        case listing
    }
    
    enum ListingKeys: String, CodingKey {
        case bedrooms
        case city
        case id
        case primaryHost = "primary_host"
    }
    enum PrimaryHostKeys: String, CodingKey {
        case firstName = "first_name"
        case pictureUrl = "picture_url"
    }
    
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: TopLevelKeys.self)
        
        let Listcontainer = try container.nestedContainer(keyedBy: ListingKeys.self, forKey: .listing)

        let bedrooms: Double = try Listcontainer.decode(Double.self, forKey: .bedrooms)
        let city: String = try Listcontainer.decode(String.self, forKey: .city)
        let id: Int = try Listcontainer.decode(Int.self, forKey: .id)

        let primaryHost = try Listcontainer.decode(PrimaryHost.self, forKey: .primaryHost)
        
        
        self.init(bedrooms: bedrooms, city: city, id: id, primaryHost: primaryHost)
        
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
class Networking {
    
    // domain.com?api_key=123456678&id=1
    
    let session = URLSession.shared
    let url = URL(string: "https://api.airbnb.com/v2/search_results?key=915pw2pnf4h1aiguhph5gc5b2")!
    func getInfo(completion: @escaping(Result<[Listing]>) -> Void) {
        let request = URLRequest(url: url)
        

        session.dataTask(with: request) { (data, response, error) in
            if let data = data {
                
                let decoder = JSONDecoder()
                guard let info = try? decoder.decode(SearchResult.self, from: data) else {
                    return completion(Result.failure(NetworkError.couldNotParseJSON))
                }
        
                completion(Result.success(info.searchResult))
                }
        }.resume()
            
         }
 }

let result = Networking()
result.getInfo() {(response) in
    print(response)
}
PlaygroundPage.current.needsIndefiniteExecution = true 



