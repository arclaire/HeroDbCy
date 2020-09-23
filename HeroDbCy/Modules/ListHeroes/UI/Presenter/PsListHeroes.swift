//
//  PsListHeroes.swift
//  HeroDbCy
//
//  Created by Lucy on 17/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import Foundation

class PsListHeroes: BaseViewModel {
    var wfVc: WfListHeroes?
    var interactor: IListHeroes?
    var vc : VCListHeroes?
    
    var dataSourceObservable = BehaviorRelay<[ModelHeroes]?>(value:nil)
    var dataSource: [ModelHeroes]? {
        get {
            return dataSourceObservable.value
        }
        set {
            dataSourceObservable.accept(newValue)
        }
    }
    
    func fetchHeroesData() {
        if let interactor = self.interactor {
            if let data = interactor.dataManager?.retrieveHeroes() {
                if data.count > 0 {
                    self.vc?.model = data
                    self.dataSource = data
                    self.vc?.model = data
                    self.vc?.modelFiltered = data
                    self.interactor?.model = data
                } else {
                    if Connectivity.isConnectedToInternet {
                        interactor.fetchHeroesFromServices()
                            .catchError({ [unowned self] error -> Observable<[ModelHeroes]?> in
                                self.handleNetworkError(error)
                                self.wfVc?.displayAlert(message: error.localizedDescription)
                                return Observable.just(nil)
                            })
                            .subscribe(onNext: { [unowned self] modelResponse in
                                if let validModel = modelResponse {
                                    self.interactor?.dataManager?.saveHeroes(validModel)
                                    self.dataSource = validModel
                                    self.state.accept(.finished)
                                    self.vc?.model = validModel
                                    self.vc?.modelFiltered = validModel
                                    self.interactor?.model = validModel
                                } else {
                                    self.state.accept(.failed)
                                }
                            }).disposed(by: disposeBag)
                    } else {
                        self.wfVc?.displayAlert(message:"No Internet Connection")
                    }
                }
            }
        }
    }
    
   
    func getRolesData() -> [String]? {
        
        if let arr = self.interactor?.dataManager?.arrRoles {
            return arr
        }
        return nil
    }
    
    func goToDetail(model: ModelHeroes) {
        self.wfVc?.navigateToDetail(model: model)
    }
}
