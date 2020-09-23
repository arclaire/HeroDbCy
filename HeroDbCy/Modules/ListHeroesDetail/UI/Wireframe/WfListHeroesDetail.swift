//
//  WfListHeroesDetail.swift
//  HeroDbCy
//
//  Created by Lucy on 21/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import UIKit

class WfListHeroesDetail {

    var presenter: PsListHeroesDetail?
    var vc: VCListHeroesDetail?

    func initiateVC() -> VCListHeroesDetail {
        let storyboard = UIStoryboard.getMainStoryboard()
        let viewController = storyboard.instantiateViewController(withIdentifier: ID_VC_ListHeroesDetail) as! VCListHeroesDetail
        viewController.eventHandler = self.presenter
        return viewController
    }
    
    func push(vc: UIViewController, data: ModelHeroes) {
        self.vc = self.initiateVC()
        self.vc?.model = data
        vc.navigationController?.pushViewController(self.vc!, animated: true)
    }

    
}

