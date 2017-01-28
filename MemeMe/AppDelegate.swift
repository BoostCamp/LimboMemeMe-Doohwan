//
//  AppDelegate.swift
//  MemeMe
//
//  Created by doohwan Lee on 2017. 1. 16..
//  Copyright © 2017년 doohwan Lee. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

   
    var window: UIWindow?
    var memes = [Meme]()
    var anyArr : [[String : Any]] = []
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        // App 부팅 시 UserDefaults에 저장되어 있는 데이터 로드
        let setting = UserDefaults.standard
        if let meme = setting.array(forKey: "memes") as? [[String : Any]]{ //DictionaryArray로 Type 캐스팅
            anyArr = meme
            for item in meme {
                let topText = item["topText"] as! NSString as String
                let bottomText = item["bottomText"] as! NSString as String
                let originalImage = UIImage(data: (item["originalImage"] as! NSData) as Data)
                let memedImage = UIImage(data: (item["memedImage"] as! NSData) as Data)
                let temp = Meme(topText: topText, bottomText: bottomText, originalImage: originalImage, memedImgae: memedImage)
                memes.append(temp)
            }
            
        }
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


}

