//
//  HealthKitManager.swift
//  FinalChallenge
//
//  Created by Guilherme Paciulli on 15/11/18.
//  Copyright © 2018 Osniel Lopes Teixeira. All rights reserved.
//

import Foundation
import HealthKit

class HealthKitManager {
    
    static let shared = HealthKitManager()
    
    let healthStore = HKHealthStore()
    
    let mindfulType = HKObjectType.categoryType(forIdentifier: .mindfulSession)
    
    private let healthDataAvailableKey = "healthDataAvailableKey"
    
    private init() {}
    
    func isHealthDatAvailable() -> Bool {
        return UserDefaults.standard.bool(forKey: self.healthDataAvailableKey)
    }
    
    func askForPermission(completion: @escaping (Bool, DataAccessError?) -> ()) {
        let typesToRead = Set([HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!])
        let typesToShare = Set([HKObjectType.categoryType(forIdentifier: HKCategoryTypeIdentifier.mindfulSession)!])
        
        self.healthStore.requestAuthorization(toShare: typesToShare, read: typesToRead) { (success, error) in
            UserDefaults.standard.set(success, forKey: self.healthDataAvailableKey)
            completion(success, error == nil ? nil : DataAccessError(message: "Error when requesting access to Health Kit"))
        }
    }
    
    private func retrieveMindfullnessHealthData(from: Date, to: Date, completion: @escaping (HKSampleQuery, [HKSample]?, Error?) -> ()) {
        
        let sortDescriptor = NSSortDescriptor(key: HKSampleSortIdentifierEndDate, ascending: false)

        let endDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: to)
        let startDate = Calendar.current.date(bySettingHour: 23, minute: 59, second: 59, of: from)
        let predicate = HKQuery.predicateForSamples(withStart: startDate, end: endDate, options: [])

        let query = HKSampleQuery(sampleType: self.mindfulType!, predicate: predicate, limit: 0, sortDescriptors: [sortDescriptor], resultsHandler: completion)
        
        healthStore.execute(query)
    }
    
    func retrieveMindfullness(from: Date, to: Date, completion: @escaping (TimeInterval?, DataAccessError?) -> ()) {
        if !self.isHealthDatAvailable() {
            completion(nil, DataAccessError(message: "You didn't grant access to your health data"))
        }
        
        self.retrieveMindfullnessHealthData(from: from, to: to, completion: { query, samples, err in
            guard let hksamples = samples, err == nil else {
                completion(nil, DataAccessError(message: err!.localizedDescription))
                return
            }
            completion(hksamples.map(self.calculateTime).reduce(0, { $0 + $1 }), nil)
        })
    }
    
    private func calculateTime(sample: HKSample) -> TimeInterval {
        return sample.endDate.timeIntervalSince(sample.startDate)
    }
    
}
