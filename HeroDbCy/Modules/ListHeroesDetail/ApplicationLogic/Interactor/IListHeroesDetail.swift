//
//  IListHeroesDetail.swift
//  HeroDbCy
//
//  Created by Lucy on 21/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class IListHeroesDetail: NSObject {
    var dataManager : ManagerHeroes?
   
    var model: [ModelHeroes]?
    var modelSelected: ModelHeroes = ModelHeroes()
    
    init(manager: ManagerHeroes) {
        self.dataManager = manager
       
    }
    
    func filterSimilarHeroes() -> [ModelHeroes] {
        var arr = [ModelHeroes]()
        if let data = self.model {
            arr = data.filter {
                $0.primary_attr == self.modelSelected.primary_attr
            }
           
            if self.modelSelected.primary_attr == "agi" {
                arr = arr.sorted(by: { $0.base_agi! > $1.base_agi! })
            } else if self.modelSelected.primary_attr == "str" {
                arr = arr.sorted(by: { $0.base_attack_max! > $1.base_attack_max! })
            } else {
                arr = arr.sorted(by: { $0.base_mana! > $1.base_mana! })
            }
        }
        return arr
    }
}
