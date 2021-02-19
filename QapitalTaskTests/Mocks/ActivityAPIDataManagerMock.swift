//
//  ActivityAPIDataManagerMock.swift
//  QapitalTaskTests
//
//  Created by Omima Ibrahim on 19/02/2021.
//

import Foundation
import Mockit
import Quick
import Nimble

@testable import QapitalTask

class ActivityAPIDataManagerMock: ActivityAPIDataManager, Mock {

    // required by Mockit framework Mock protocol
    let callHandler: CallHandler

    // required by Mockit framework Mock protocol
    init(testCase: XCTestCase) {
        callHandler = CallHandlerImpl(withTestCase: testCase)
    }
    
    // required by Mockit framework Mock protocol
    func instanceType() -> ActivityAPIDataManager {
        return self
    }

}
