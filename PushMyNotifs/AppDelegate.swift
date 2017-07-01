//
//  AppDelegate.swift
//  PushMyNotifs
//
//  Created by Josiah Mory on 6/27/17.
//  Copyright © 2017 kickinbahk Productions. All rights reserved.
//

import UIKit
import Firebase
import FirebaseInstanceID
import FirebaseMessaging
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate, UNUserNotificationCenterDelegate {

  var window: UIWindow?


  func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
    // Override point for customization after application launch.
    UNUserNotificationCenter.current().delegate = self
    Messaging.messaging().delegate = self
    Messaging.messaging().shouldEstablishDirectChannel = true
    let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
    UNUserNotificationCenter.current().requestAuthorization(options: authOptions,
                                                            completionHandler: { _, _ in })
    application.registerForRemoteNotifications()
    let token = Messaging.messaging().fcmToken
    print("FCM Token: \(token ?? "no token")")
    
    FirebaseApp.configure()
    return true
  }

  func applicationWillResignActive(_ application: UIApplication) {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
  }

  func applicationDidEnterBackground(_ application: UIApplication) {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
  }

  func applicationWillEnterForeground(_ application: UIApplication) {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
  }

  func applicationDidBecomeActive(_ application: UIApplication) {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
  }

  func applicationWillTerminate(_ application: UIApplication) {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
  }

  func application(_ application: UIApplication, didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
    Messaging.messaging().apnsToken = deviceToken
    InstanceID.instanceID().setAPNSToken(deviceToken, type: .sandbox)
    InstanceID.instanceID().setAPNSToken(deviceToken, type: .prod)

  }
  
}

extension AppDelegate : MessagingDelegate {
  func messaging(_ messaging: Messaging, didRefreshRegistrationToken fcmToken: String) {
    print("Firebase registration token: \(fcmToken)")
  }

  func messaging(_ messaging: Messaging, didReceive remoteMessage: MessagingRemoteMessage) {
    print("Received data message: \(remoteMessage.appData)")
    guard let data =
      try? JSONSerialization.data(withJSONObject: remoteMessage.appData, options: .prettyPrinted),
      let prettyPrinted = String(data: data, encoding: .utf8) else { return }
    print("Received direct channel message:\n\(prettyPrinted)")
  }
}
