//
//  singleton.swift
//  ProductHuntApi
//
//  Created by Sky Xu on 9/26/17.
//  Copyright © 2017 Sky Xu. All rights reserved.
//

import Foundation
class Singleton {
    static let sharedSession = URLSession.shared
    private init() {}
}
