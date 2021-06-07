//
//  SceneDelegate.swift
//  IOS_News
//
//  Created by uzzing on 2021/05/23.
//

import UIKit
import SwiftUI
import RealmSwift
import CoreData

class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        
        let context = persistentContainer.viewContext

        
        // Create the SwiftUI view that provides the window contents.
        if let windowScene = scene as? UIWindowScene {
          do {
            let realm = try Realm()
            let window = UIWindow(windowScene: windowScene)
            let contentView = ContentView()
              .environmentObject(ItemStore(realm: realm))
                .environment(\.managedObjectContext, context)
                .environmentObject(DateFormatter.memoDateFormatter)
                .environmentObject(KeyboardObserver())
            
            window.rootViewController = UIHostingController(rootView: contentView)
            self.window = window
            window.makeKeyAndVisible()
          } catch let error {
            fatalError("Failed to open Realm. Error:\(error.localizedDescription)")
          }
        }
    }

    func sceneDidDisconnect(_ scene: UIScene) {
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not necessarily discarded (see `application:didDiscardSceneSessions` instead).
    }

    func sceneDidBecomeActive(_ scene: UIScene) {
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    func sceneWillResignActive(_ scene: UIScene) {
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    func sceneWillEnterForeground(_ scene: UIScene) {
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    //***************
    // <-- core data -->
    func sceneDidEnterBackground(_ scene: UIScene) {
      saveContext()
    }

    // MARK: - Core Data stack
    lazy var persistentContainer: NSPersistentContainer = {
      let container = NSPersistentContainer(name: "Memo")
      container.loadPersistentStores { _, error in
        if let error = error as NSError? {
          // You should add your own error handling code here.
          fatalError("Unresolved error \(error), \(error.userInfo)")
        }
      }
      return container
    }()

    // MARK: - Core Data Saving support
    func saveContext() {
      let context = persistentContainer.viewContext
      if context.hasChanges {
        do {
          try context.save()
        } catch {
          // The context couldn't be saved.
          // You should add your own error handling here.
          let nserror = error as NSError
          fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
        }
      }
    }

}

