//
//  CloudKitManager.swift
//  Journal-CloudKit
//
//  Created by Colby Mehmen on 7/16/23.
//

import Foundation
import CloudKit

class CloudKitManager {
    let privateDB = CKContainer.default().privateCloudDatabase
    
    func save(records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ err: Error?) -> Void)?, completion: ((_ record: [CKRecord]?, _ err: Error?) -> Void)?) {
        modify(records: records, perRecordCompletion: perRecordCompletion, completion: completion)
    }
    
    func modify(records: [CKRecord], perRecordCompletion: ((_ record: CKRecord?, _ err: Error?) -> Void)?, completion: ((_ record: [CKRecord]?, _ err: Error?) -> Void)?) {
        let operation = CKModifyRecordsOperation(recordsToSave: records)
        
        operation.savePolicy = .changedKeys
        operation.queuePriority = .high
        operation.qualityOfService = .userInteractive
        
        operation.perRecordCompletionBlock = perRecordCompletion
        operation.modifyRecordsCompletionBlock = { (records, recordIds, error) in
            completion?(records, error)
        }
        
        privateDB.add(operation)
    }
}
