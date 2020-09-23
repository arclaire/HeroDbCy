//
//  NetworkHeroes.swift
//  HeroDbCy
//
//  Created by Lucy on 19/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class NetworkHeroes: NSObject {
    class func fetchHeroes(string: String) -> Observable<[ModelHeroes]?> {
        //q={city name}&appid={your api key}//9383
        let url = NetworkConfigurations.properBaseUrl 
          return NetworkProvider().get(url).map { response in
            
            if let data = response as? [AnyHashable: Any] {
                do {
                    let jsonData = try JSONSerialization.data(withJSONObject: data, options: [])
                    let decode = try JSONDecoder().decode([ModelHeroes].self, from: jsonData)
                    return decode
                } catch let error {
                    print(error)
                }
            }
            
            return nil
        }
    }
}
