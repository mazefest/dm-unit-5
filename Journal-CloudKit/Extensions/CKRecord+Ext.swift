//
//  CKRecord+Ext.swift
//  Journal-CloudKit
//
//  Created by Colby Mehmen on 7/16/23.
//

import Foundation
import CloudKit

extension CKRecord {
  convenience init(entry: Entry) {
    self.init(recordType: EntryConstants.RecordType, recordID: entry.ckRecordID)
    self.setValue(entry.title, forKey: EntryConstants.TitleKey)
    self.setValue(entry.body, forKey: EntryConstants.BodyKey)
    self.setValue(entry.timestamp, forKey: EntryConstants.TimestampKey)
  }
}
