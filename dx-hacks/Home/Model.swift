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
//
//            let apitoken = "NOFpHbljpypy3cGutXbt7j0UjQ9nsoM30uuKK5VP"
//            let domain = "https://cvoak2reoo3b.cybozu.com/k/5/show#record=1"
//
            let domain = "https://mmddb0x4ggr1.cybozu.com/k/v1/record.json?app=7&id=1"
            let apitoken = "VJAYYM8eklgh9Iwf3MmQVa6VPMIVeaMXrpXypNUo"
            
            // Init authenticationAuth
            let kintoneAuth = Auth()
            kintoneAuth.setApiToken(apitoken)
            
            // Init Connection without "guest space ID"
            let kintoneConnection = Connection(domain, kintoneAuth)
        
            var fileTestRecord: Dictionary<String, FieldValue> = [:]
            // Init Record Module
            let kintoneRecord = Record(kintoneConnection)
            
            // execute get record API
            let appID = 7
            let recordID = 1
            kintoneRecord.getRecord(appID, recordID).then { response in
                let resultData = response.getRecord()!
                print(resultData["$id"]?.getValue() ?? "")
                print(resultData["file"]?.getValue() ?? "")
            }.catch { error in
                if error is KintoneAPIException {
                    print((error as! KintoneAPIException).toString()!)
                }
            }
        }
    
    func filedownload() {
        let domain = "https://mmddb0x4ggr1.cybozu.com/k/v1/record.json?app=7&id=1"
        let apitoken = "VJAYYM8eklgh9Iwf3MmQVa6VPMIVeaMXrpXypNUo"
        
        // Init authenticationAuth
        let kintoneAuth = Auth()
        kintoneAuth.setApiToken(apitoken)
        
        // Init Connection without "guest space ID"
        let kintoneConnection = Connection(domain, kintoneAuth)
        
        let fileManager = File(kintoneConnection)
        let recordManager = Record(kintoneConnection)
        var fieldCode = "SINGLE_LINE_TEXT"
        var fileTestRecord: Dictionary<String, FieldValue> = [:]
        var field = FieldValue()
        field.setType(FieldType.SINGLE_LINE_TEXT)
        field.setValue("testDownloadSuccessForSingleFile")
        fileTestRecord[fieldCode] = field
        let testBundle = Bundle(for: type(of: self))
        guard let upload_file_path = testBundle.url(forResource: "test", withExtension: "txt") else {
            return
        }
    }
    
}
