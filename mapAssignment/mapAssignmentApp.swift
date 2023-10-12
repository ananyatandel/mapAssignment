//
//  mapAssignmentApp.swift
//  mapAssignment
//
//  Created by Ananya Tandel on 10/11/23.
//

import SwiftUI
import UserNotifications

@main
struct NotificationDemoApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
                .onAppear {
                    UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) { success, error in
                        if success {
                            print("Notifs are on!")
                        } else if let error = error {
                            print(error)
                        }
                    }
                }
        }
    }
}



