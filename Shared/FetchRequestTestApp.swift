//
//  FetchRequestTestApp.swift
//  Shared
//
//  Created by Jeff Boek on 8/10/20.
//

import SwiftUI
import CoreData

@main
struct FetchRequestTestApp: App {
    let container: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "FetchRequestTest")

        container.loadPersistentStores { storeDescription, error in
            if let error = error {
                print("Unresolved error \(error)")
            }
        }
        
        return container
    }()
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, container.viewContext)
        }.commands {
            SidebarCommands()
        }
    }
}
