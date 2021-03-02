//
//  SuperHeroDataSource.swift
//  SuperHero App Zoho Assignment
//
//  Created by Dhruvil Patel on 02/03/21.
//  Copyright © 2021 Dhruvil Patel. All rights reserved.
//

import UIKit
import Kingfisher

class SuperHeroDataSource: NSObject {
    
    class func createList() -> [SuperHero] {
        let nameArray  = UserDefaults.standard.object(forKey: "name") as? [String] ?? []
        let imageArray  = UserDefaults.standard.object(forKey: "image") as? [String] ?? []
        let idArray  = UserDefaults.standard.object(forKey: "id") as? [String] ?? []
        return [SuperHero(name: nameArray[0], element: .Grass, imagess: imageArray[0], id: idArray[0]),
                SuperHero(name: nameArray[1], element: .Grass, imagess: imageArray[1], id: idArray[1]),
                SuperHero(name: nameArray[2], element: .Grass, imagess: imageArray[2], id: idArray[2]),
                SuperHero(name: nameArray[3], element: .Fire, imagess: imageArray[3], id: idArray[3]),
                SuperHero(name: nameArray[4], element: .Fire, imagess: imageArray[4], id: idArray[4]),
                SuperHero(name: nameArray[5], element: .Fire, imagess: imageArray[5], id: idArray[5]),
                SuperHero(name: nameArray[6], element: .Water, imagess: imageArray[6], id: idArray[6]),
                SuperHero(name: nameArray[7], element: .Water, imagess: imageArray[7], id: idArray[7]),
                SuperHero(name: nameArray[8], element: .Water, imagess: imageArray[8], id: idArray[8]),
                SuperHero(name: nameArray[9], element: .Water, imagess: imageArray[9], id: idArray[9])]
    }

}
