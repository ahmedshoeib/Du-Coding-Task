//
//  MockHomeRepository.swift
//  DuCodingTaskTests
//
//  Created by Ahmed Shoeib on 8/31/19.
//  Copyright © 2019 Du. All rights reserved.
//

import XCTest
@testable import DuCodingTask

class HomeViewRouterMock {
    weak var viewController: UIViewController?
    
    var routeHistory: [String] = []
    
    func navigateToWebViewWithUrl(url:String) {
        routeHistory.append("WebViewViewController")
    }
    
    func navigateToFindUsViewController(homePayLoad:HomePayLoad) {
        routeHistory.append("FindUsViewController")
    }
}

class HomeViewModelTests: XCTestCase {
    
    var viewModel: HomeViewModel!
    var router: HomeViewRouterMock!
    
    override func setUp() {
        
        router = HomeViewRouterMock()
        //        viewModel = RepoSearchViewModel(with: router, githubService: GithubServiceMock())
    }
    
    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testPerformanceExample() {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }
    
}
