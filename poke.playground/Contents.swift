//: A UIKit based Playground for presenting user interface
  
import UIKit
import Foundation
import PlaygroundSupport

struct Poke: Decodable {
    let name: String
    let abilities: [Abilities]
    enum searchKey: String, CodingKey {
        case name
        case abilities
    }
    init(name: String, abilities: [Abilities]) {
        self.name = name
        self.abilities = abilities
    }
    
    init(from decoder: Decoder) throws{
        let container = try decoder.container(keyedBy: searchKey.self)
        let name = try container.decode(String.self, forKey: .name)
        let abilities = try container.decode([Abilities].self, forKey: .abilities)
        self.init(name: name, abilities: abilities)
    }
    
    
}

struct Abilities: Decodable {
    let isHidden: Bool
    let ability: Ability
    
    enum searchKey: String, CodingKey {
        case isHidden = "is_hidden"
        case ability
    }
//    init for change name to camelcase
    init(isHidden: Bool, ability: Ability) {
        self.isHidden = isHidden
        self.ability = ability
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: searchKey.self)
        let isHidden = try container.decode(Bool.self, forKey: .isHidden)
        let ability = try container.decode(Ability.self, forKey: .ability)
        self.init(isHidden: isHidden, ability: ability)
        
    }

}

struct Ability: Decodable {
    let abilityName: String
    let url: String?
    
    enum searchKey: String, CodingKey {
        case abilityName = "name"
        case url
    }
    
    init(abilityName: String, url: String) {
        self.abilityName = abilityName
        self.url = url
    }
    init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: searchKey.self)
        let abilityName = try container.decode(String.self, forKey: .abilityName)
        let url = try container.decode(String.self, forKey: .url)
        self.init(abilityName: abilityName, url: url)
    }
    
}

enum Result<T> {
    case success(T)
    case failure(NetworkError)
}

enum NetworkError: Error {
    case unknown
    case couldNotParseJSON
}

class MyViewController : UIViewController {
    override func loadView() {
//        super.loadView()
//        networking request
        let session = URLSession.shared
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon/1/")!
        func getInfo(completion: @escaping(Result<Poke>) -> Void) {
            let request = URLRequest(url: url)
            session.dataTask(with: request) { (data, response, error) in
                if let data = data {
                    let decoder = JSONDecoder()
                    guard  let info = try? decoder.decode(Poke.self, from: data) else {
                        return completion(Result.failure(NetworkError.couldNotParseJSON))
                    }
                    completion(Result.success(info))
                }
            }.resume()
        }
        
        getInfo(){ (response) in
            print(response)
            
        }
        let view = UIView()
        view.backgroundColor = .white

        let label = UILabel()
        label.frame = CGRect(x: 150, y: 200, width: 200, height: 20)
        label.text = "Hello World!"
        label.textColor = .black
        
        view.addSubview(label)
        self.view = view
    }
}

PlaygroundPage.current.liveView = MyViewController()
