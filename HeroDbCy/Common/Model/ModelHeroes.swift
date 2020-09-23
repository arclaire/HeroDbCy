//
//  ModelHeroes.swift
//  HeroDbCy
//
//  Created by Lucy on 19/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class ModelHeroes: Codable {
    var id: Int?
    var name: String?
    var localized_name: String?
    var primary_attr: String?
    var attack_type: String?
    var roles: [String]?
    var img: String?
    var icon: String?
    var base_health: Double?
    var base_health_regen: Double?
    var base_mana: Double?
    var base_mana_regen: Double?
    var base_armor: Double?
    var base_mr: Double?
    var base_attack_min : Double?
    var base_attack_max: Double?
    var base_str: Double?
    var base_agi: Double?
    var base_int: Double?
    var move_speed: Int?
    
    func getStrAtkInfo()-> String {
        var strMin = "0"
        var strMax = "0"
        
        if let max = self.base_attack_max {
            strMax = String(max)
        }
        
        if let min = self.base_attack_min {
            strMin = String(min)
        }
        
        return strMin + " - " + strMax
    }
    
    func getURlImageFullString() -> String? {
        if let str = self.img {
            let strUrl = NetworkConfigurations.properBaseUrl + str
            return strUrl
        }
        return nil
    }
    
    func getURlImageIconFullString() -> String? {
        if let str = self.icon {
            let strUrl = NetworkConfigurations.properBaseUrl + str
            return strUrl
        }
        return nil
    }
    
    
    
}
