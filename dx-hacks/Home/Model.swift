//
//  Model.swift
//  dx-hacks
//
//  Created by 山田楓也 on 2021/05/29.
//

import Foundation
import FBLPromises
import kintone_ios_sdk

class Model {
    func testGetRecord() {
            // This is an example of a functional test case.
            // Use XCTAssert and related functions to verify your tests produce the correct results.
            print("test start")

            let apitoken = "NOFpHbljpypy3cGutXbt7j0UjQ9nsoM30uuKK5VP"
            let domain = "https://cvoak2reoo3b.cybozu.com/k/5/show#record=1"
            
            // Init authenticationAuth
            let kintoneAuth = Auth()
            kintoneAuth.setApiToken(apitoken)
            
            // Init Connection without "guest space ID"
            let kintoneConnection = Connection(domain, kintoneAuth)
            
            // Init Record Module
            let kintoneRecord = Record(kintoneConnection)
            
            // execute get record API
            let appID = 5
            let recordID = 1
            kintoneRecord.getRecord(appID, recordID).then { response in
                let resultData = response.getRecord()!
                print(resultData["$id"]?.getValue())
                print(resultData["text"]?.getValue())
            }.catch { error in
                if error is KintoneAPIException {
                    print((error as! KintoneAPIException).toString()!)
                }
            }
        }
}
