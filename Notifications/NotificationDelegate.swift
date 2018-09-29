import UIKit
import UserNotifications

class NotificationDelegate: NSObject, UNUserNotificationCenterDelegate {

    func userNotificationCenter(_ center: UNUserNotificationCenter, didReceive response: UNNotificationResponse, withCompletionHandler completionHandler: @escaping () -> Void) {

        switch response.actionIdentifier {
            case UNNotificationDismissActionIdentifier:break
            case UNNotificationDefaultActionIdentifier:break
            default:break
        }
        print(response)
        completionHandler()
    }

    func userNotificationCenter(_ center: UNUserNotificationCenter, willPresent notification: UNNotification, withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.alert, .badge, .sound]) //required to show notification when in foreground
    }

}
