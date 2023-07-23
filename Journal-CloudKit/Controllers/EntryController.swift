//
//  EntryController.swift
//  Journal-CloudKit
//
//  Created by Colby Mehmen on 7/16/23.
//

import Foundation
import CloudKit

enum EntryError: Error {
    case custom(String)
}

class EntryController {
    let privateDB = CKContainer.default().privateCloudDatabase
    
    static let shared = EntryController()
    
    var entries: [Entry] = []
    
    init() {
        
    }

    func create(title: String, body: String, completion: @escaping (Result<Entry?, EntryError>) -> Void) {
        let newEntry = Entry(title: title, body: body)
        save(entry: newEntry, completion: completion)
    }
    
    func save(entry: Entry, completion: @escaping (_ result: Result<Entry?, EntryError>) -> Void) {
        let record = CKRecord(entry: entry)
        
        privateDB.save(record) { record, error in
            if let error = error {
                print(error.localizedDescription)
                completion(.failure(.custom(error.localizedDescription)))
                return
            }
            
            completion(.success(entry))
        }
    }
        
    func fetchEntriesWith(completion: @escaping (_ result: Result<[Entry]?, EntryError>) -> Void) {
        let query = CKQuery(recordType: EntryConstants.RecordType, predicate: .init(value: true))
        privateDB.fetch(withQuery: query) { result in
            switch result {
            case .success(let result):
                let matchResults = result.matchResults
                
                let records = matchResults.compactMap { (_, result) in
                    if case .success(let record) = result {
                        return record
                    }
                    return nil
                }
                let entries = records.compactMap({Entry(ckRecord: $0)})
                completion(.success(entries))
                    
            case .failure(let failure):
                completion(.failure(.custom(failure.localizedDescription)))
            }
        }
        
    }
}
