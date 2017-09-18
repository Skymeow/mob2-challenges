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
    let abilitiy: Ability
    
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
        let container = try decoder.container(keyedBy: searchKey.self )
        let isHidden = try container.decode(Bool.self, forKey: .isHidden)
        let ability = try container.decode(Ability.self, forkey: .ability)
        self.init(isHidden: isHidden, ability: ability)
        
    }

}

struct Ability: Decodable {
    let name: String
    let url: String?
    
    enum searchKey: String, CodingKey {
        case name
        case url
    }
    
    
}

class MyViewController : UIViewController {
    override func loadView() {
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
