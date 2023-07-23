//
//  EntryConstants.swift
//  Journal-CloudKit
//
//  Created by Colby Mehmen on 7/16/23.
//

import Foundation

struct EntryConstants {
    static let TitleKey = "title"
    static let BodyKey = "body"
    static let TimestampKey = "timestamp"
    static let RecordType = "Entry"
    static let EntryCellIdentifier = "EntryCellIdentifier"
}

struct SegueConstants {
    static let toNewEntry = "toNewEntry"
    static let toEditEntry = "toEditEntry"
}
