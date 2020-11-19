//
//  ToDo_RealmApp.swift
//  ToDo_Realm
//
//  Created by Kevin Vo on 11/3/20.
//

import SwiftUI


@main
struct ToDo_RealmApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    
    var body: some Scene {
        WindowGroup {
            ContentView(content: "", todo: ToDoModel(toDoModelRealm: ToDoModelRealm()))
                .environmentObject(ToDoViewModel())
        }
    }
}




