//
//  HeroDbCyTests.swift
//  HeroDbCyTests
//
//  Created by Lucy on 17/09/20.
//  Copyright © 2020 Lucy. All rights reserved.
//

import XCTest
@testable import HeroDbCy

class HeroDbCyTests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

    func testCallFetchHeroes() {
        let dataManager = ManagerHeroes()
        let interactor = IListHeroes(manager: dataManager)
        let presenter = PsListHeroes()
        presenter.interactor = interactor
        
        interactor.fetchHeroesFromServices()
        .catchError({ [unowned self] error -> Observable<[ModelHeroes]?> in
            XCTFail("Call API got error")
            return Observable.just(nil)
        })
        .subscribe(onNext: { [unowned self] modelResponse in
            if let _ = modelResponse {
               XCTAssert(true, "Call API success and retrieve response with valid model")
            } else {
                XCTAssert(false, "Model not retrieve")
            }
        }).disposed(by: DisposeBag())
        
    }
    
    func testConnectivity() {
        if Connectivity.isConnectedToInternet {
            XCTAssert(true, "Connected to the internet")
        } else {
            XCTAssert(false, "No internet connection")
        }
    }
    
    func loadCoreData() {
        let dataManager = ManagerHeroes()
        let arr = dataManager.retrieveHeroes()
        if arr.count > 0 {
            XCTAssert(true, "DataLoaded")
        } else {
            XCTAssert(false, "No data")
        }
    }
    
}
