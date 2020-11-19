//
//  AppDelegate.swift
//  ToDo_Realm
//
//  Created by Kevin Vo on 11/17/20.
//

import Foundation
import UIKit
import RealmSwift


class AppDelegate: NSObject, UIApplicationDelegate{
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool{
        
        var config = Realm.Configuration(
            // Set the new schema version. This must be greater than the previously used
            // version (if you've never set a schema version before, the version is 0).
            schemaVersion: 1,

            // Set the block which will be called automatically when opening a Realm with
            // a schema version lower than the one set above
            migrationBlock: { migration, oldSchemaVersion in
                // We haven’t migrated anything yet, so oldSchemaVersion == 0
                if (oldSchemaVersion < 1) {
                    // Nothing to do!
                    // Realm will automatically detect new properties and removed properties
                    // And will update the schema on disk automatically
                    //migration.deleteData(forType: ToDoModelRealm.className())
                }
            })
        
        Realm.Configuration.defaultConfiguration = config
        config = Realm.Configuration()
        config.deleteRealmIfMigrationNeeded = true
        
        return true
    }
}
