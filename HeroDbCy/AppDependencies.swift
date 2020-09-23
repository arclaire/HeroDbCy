//
//  AppDependencies.swift
//  HeroDbCy
//
//  Created by Lucy on 23/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class AppDependencies {
    
    func installRootViewControllerIntoWindow(_ window: UIWindow) {
        let wf = AppDependencies.configureDependecy()
        wf.presentVCToWindow(window)
    }
    
    class func configureDependecy() -> WfListHeroes {
        let wf = WfListHeroes()
     
        let rootWireframe = WFRoot()
        
        let presenter = PsListHeroes()
        let datamanager = ManagerHeroes()
        let interactor = IListHeroes(manager: datamanager)
        
        presenter.interactor = interactor
        presenter.wfVc = wf
        
        wf.presenter = presenter
        wf.wfRoot = rootWireframe
    
        
        return wf
    }
    
    deinit {
        print("deinit")
    }
}
