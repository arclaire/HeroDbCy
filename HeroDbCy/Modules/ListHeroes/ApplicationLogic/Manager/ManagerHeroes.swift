//
//  ManagerHeroes.swift
//  HeroDbCy
//
//  Created by Lucy on 20/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation
import CoreData

class ManagerHeroes {
    let arrRoles: [String] = ["all", "carry", "nuker", "initiator", "disabler", "durable", "escape", "support", "pusher", "jungler"]
    let context = (UIApplication.shared.delegate as! AppDelegate).persistentContainer.viewContext
    
    func saveHeroes(_ heroes: [ModelHeroes]) {
        for hero in heroes {
            let newHero = NSEntityDescription.insertNewObject(forEntityName: "Hero", into: self.context)
            newHero.setValue(hero.id, forKey: "id")
            newHero.setValue(hero.name, forKey: "name")
            newHero.setValue(hero.localized_name, forKey: "localized_name")
            newHero.setValue(hero.primary_attr, forKey: "primary_attr")
            newHero.setValue(hero.attack_type, forKey: "attack_type")
            newHero.setValue(hero.roles, forKey: "roles")
            newHero.setValue(hero.img, forKey: "img")
            newHero.setValue(hero.icon, forKey: "icon")
            newHero.setValue(hero.base_health, forKey: "base_health")
            newHero.setValue(hero.base_health_regen, forKey: "base_health_regen")
            newHero.setValue(hero.base_mana, forKey: "base_mana")
            newHero.setValue(hero.base_mana_regen, forKey: "base_mana_regen")
            newHero.setValue(hero.base_armor, forKey: "base_armor")
            newHero.setValue(hero.base_mr, forKey: "base_mr")
            newHero.setValue(hero.base_attack_min, forKey: "base_attack_min")
            newHero.setValue(hero.base_attack_max, forKey: "base_attack_max")
            newHero.setValue(hero.base_str, forKey: "base_str")
            newHero.setValue(hero.base_agi, forKey: "base_agi")
            newHero.setValue(hero.base_int, forKey: "base_int")
        }
        do {
            try context.save()
            print("Success")
        } catch {
            print("Error saving: \(error)")
        }
    }
    
    func retrieveHeroes () -> [ModelHeroes]{
        let request: NSFetchRequest <Hero> = Hero.fetchRequest()
        var arrModel: [ModelHeroes] = [ModelHeroes]()
        do {
           let arrHero = try context.fetch(request)
            for hero in arrHero {
                let modelHero = ModelHeroes()
                if let str = hero.value(forKey: "id") as? Int {
                    modelHero.id = str
                }
                if let str = hero.value(forKey: "name") as? String {
                    modelHero.name = str
                }
                if let str = hero.value(forKey: "localized_name") as? String {
                    modelHero.localized_name = str
                }
                if let str = hero.value(forKey: "primary_attr") as? String {
                    modelHero.primary_attr = str
                }
                if let str = hero.value(forKey: "attack_type") as? String {
                    modelHero.attack_type = str
                }
                if let str = hero.value(forKey: "roles") as? [String] {
                    modelHero.roles = str
                }
                if let str = hero.value(forKey: "img") as? String {
                    modelHero.img = str
                }
                if let str = hero.value(forKey: "icon") as? String {
                    modelHero.icon = str
                }
                if let str = hero.value(forKey: "base_health") as? Double {
                    modelHero.base_health = str
                }
                if let str = hero.value(forKey: "base_health_regen") as? Double {
                    modelHero.base_health_regen = str
                }
                if let str = hero.value(forKey: "base_mana") as? Double {
                    modelHero.base_mana = str
                }
                if let str = hero.value(forKey: "base_mana_regen") as? Double {
                    modelHero.base_mana_regen = str
                }
                if let str = hero.value(forKey: "base_armor") as? Double {
                    modelHero.base_armor = str
                }
                if let str = hero.value(forKey: "base_mr") as? Double {
                    modelHero.base_mr = str
                }
                if let str = hero.value(forKey: "base_attack_min") as? Double {
                    modelHero.base_attack_min = str
                }
                if let str = hero.value(forKey: "base_attack_max") as? Double {
                    modelHero.base_attack_max = str
                }
                if let str = hero.value(forKey: "base_str") as? Double {
                    modelHero.base_str = str
                }
                if let str = hero.value(forKey: "base_agi") as? Double {
                    modelHero.base_agi = str
                }
                if let str = hero.value(forKey: "base_int") as? Double {
                    modelHero.base_int = str
                }
                arrModel.append(modelHero)
            }
        } catch {
            print("error:\(error)")
        }
        return arrModel
    }
}
