//
//  IListHeroes.swift
//  HeroDbCy
//
//  Created by Lucy on 20/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class IListHeroes: BaseViewModel {
    var dataManager : ManagerHeroes?
   
    var model: [ModelHeroes]?
    
    init(manager: ManagerHeroes) {
        self.dataManager = manager
       
    }
        
    func fetchHeroesFromServices() -> Observable<[ModelHeroes]?> {
       
        let strParam = "/api/herostats"
        let url = NetworkConfigurations.properBaseUrl + strParam
      
        return NetworkProvider().get(url).map { response in
            
            if let data = response as? [Any] {
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
 
    func filterModelWith(str: String) -> [ModelHeroes] {
        var arr = [ModelHeroes]()
        if let data = self.model {
            arr = data.filter {
                ($0.roles?.contains(str))!
            }
        }
        return arr
    }
    

}
