//
//  ActivityInteractorTests.swift
//  QapitalTaskTests
//
//  Created by Omima Ibrahim on 19/02/2021.
//

import Foundation
import Quick
import Nimble
import Mockit

@testable import QapitalTask
class ActivityInteractorTests: QuickSpec {
    
    override func spec() {
        
        var interactor: ActivityInteractor!
        var service: ActivityAPIDataManagerMock!
        
        // MARK:- Test data
        let oldest =  "2020-10-08T00:00:00+00:00"
        
        // MARK:- Testing ActivityInteractor
        describe("testing ActivityInteractor") {
            beforeEach {
                service = ActivityAPIDataManagerMock(testCase: self)
                interactor = ActivityInteractor(service: service)
            }
            
            context("Loading data Successfully"){

                context("After getting first request") {
                    
                    it("shouldn't have next page grater than oldest date") {
                       
                        let dateString = "2020-10-01T00:00:00+00:00"
                        let dateFormatter = DateFormatter()
                        dateFormatter.dateFormat = "yyyy-MM-dd'T'HH:mm:ssZ"

                        let date = dateFormatter.date(from:dateString)!

                        expect(interactor.hasNextPage(with: date, oldestDate: oldest)).to(beFalse())
                    }
                    
                }

                
            }
            
        }
        
        
        
    }
    
}


