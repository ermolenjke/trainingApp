//
//  RealmManager.swift
//  traningApp
//
//  Created by Даниил Ермоленко on 02.05.2022.
//

import Foundation
import RealmSwift

class RealmManager {
    
    static let shared = RealmManager()
    
    private init() {}
    
    let localRealm = try! Realm()
    
    func saveWorkoutModel(model: WorkoutModel) {
        
        try! localRealm.write {
            localRealm.add(model)
        }
    }
    
    func updateStatusWorkoutModel(model: WorkoutModel, bool: Bool) {
        
        try! localRealm.write {
            model.status = bool
        }
    }
    
    func updateSetsRepsWorkoutModel(model: WorkoutModel, sets: Int, reps: Int) {
        
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutReps = reps
        }
    }
    
    func updateSetsTimerWorkoutModel(model: WorkoutModel, sets: Int, timer: Int) {
        try! localRealm.write {
            model.workoutSets = sets
            model.workoutTimer = timer
        }
    }
    
    func deleteWorkoutModel(model: WorkoutModel) {
        
        try! localRealm.write {
            localRealm.delete(model)
        }
    }
    
}
