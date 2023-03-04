//
//  AppDelegate.swift
//  todolist
//
//  Created by Valc0d3 on 30/09/2022.
//

import UIKit
import CoreData
import FirebaseCore

@main
final class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        // Override point for customization after application launch.
        return true
    }
}

