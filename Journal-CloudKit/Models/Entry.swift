//
//  Entry.swift
//  Journal-CloudKit
//
//  Created by Colby Mehmen on 7/16/23.
//

import Foundation
import CloudKit

class Entry {
    var title: String
    var body: String
    var timestamp: Date
    var ckRecordID: CKRecord.ID
    
    init(title: String, body: String, timestamp: Date = Date(), ckRecordID: CKRecord.ID = CKRecord.ID(recordName: UUID().uuidString)) {
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecordID
    }
    
    init?(ckRecord: CKRecord) {
        guard let title = ckRecord[EntryConstants.TitleKey] as? String,
              let body = ckRecord[EntryConstants.BodyKey] as? String,
              let timestamp = ckRecord[EntryConstants.TimestampKey] as? Date
        else {
            return nil
        }
        
        self.title = title
        self.body = body
        self.timestamp = timestamp
        self.ckRecordID = ckRecord.recordID
    }
}
