import UIKit
import UserNotifications

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    let notificationDelegate = NotificationDelegate()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        let center =  UNUserNotificationCenter.current()
        center.delegate = notificationDelegate
        
        center.getNotificationSettings { (settings) in
            
            if settings.authorizationStatus == .notDetermined {
                center.requestAuthorization(options: [.alert, .sound, .badge], completionHandler: { (result, error) in
                    
                    print("result \(result)")
                    if !result {
                        print("error \(String(describing: error))")
                    }
                })
            }
        }
        return true
    }


}

