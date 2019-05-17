import UIKit
import UserNotifications

public enum NotificationType:String {
    case timeNotification
    case dateNotification
    case locationNotification
}

struct CategoryIdentifiers {
    static let general = "general"
}

enum NotificationAction:String {
    case dismiss = "Dismiss"
    case reminder = "Reminder"
}

class NotificationGenerator: NSObject {


    private let center =  UNUserNotificationCenter.current()
    private let identifier = NotificationType.timeNotification.rawValue
    private var authorizationStatus:UNAuthorizationStatus = .notDetermined

    override init() {

        super.init()
        center.getNotificationSettings { (settings) in
            self.authorizationStatus = settings.authorizationStatus
            self.requestAuthorizationIfNeeded()
            self.configureActions()
        }
    }

    private func configureActions() {

        //define the actions
        let dismiss = UNNotificationAction(identifier: NotificationAction.dismiss.rawValue,
                                                 title: NotificationAction.dismiss.rawValue,
                                                 options: [])

        let reminder = UNNotificationAction(identifier: NotificationAction.reminder.rawValue, title: NotificationAction.reminder.rawValue, options: [])


        //associate action with a category
        let generalCategory = UNNotificationCategory(identifier: CategoryIdentifiers.general,
                                                     actions: [dismiss, reminder],
                                                     intentIdentifiers: [],
                                                     options: [])
        center.setNotificationCategories([generalCategory])
    }

    public func displayNotification() {
        self.generateNotification()
    }

    private func requestAuthorizationIfNeeded() {

        switch authorizationStatus {
        case .authorized:
            return
        case .notDetermined:
            requestAuthorization()
        case .denied: break
        case .provisional:break
        @unknown default:
            fatalError("Unknown authorization status")
        }
        
    }

    private func requestAuthorization() {
        center.requestAuthorization(options: [.alert, .sound, .badge]) { (result, error) in
            //handle result of request failure
        }
    }

    public func display(notificationWithContent content:UNMutableNotificationContent, trigger:UNNotificationTrigger){

        //create request to display
        let request = UNNotificationRequest(identifier: content.categoryIdentifier, content: content, trigger: trigger)

        //add request to notification center
        addRequest(request: request)
    }

    private func addRequest(request:UNNotificationRequest) {

        center.add(request) { (error) in
            if error != nil {
                print("error \(String(describing: error))")
            } 
        }
    }

    private func generateNotification() {

        let content = configureNotificationContent()

        //trigger based on time, location or calendar
        let trigger = UNTimeIntervalNotificationTrigger(timeInterval:8.0, repeats: false)

        //request to display
        let request = UNNotificationRequest(identifier: "timeIntervalIdentifier", content: content, trigger: trigger)
        addRequest(request: request)
    }

    private func configureNotificationContent() -> UNMutableNotificationContent {

        let content = UNMutableNotificationContent()
        content.title = "Jurassic Park"
        content.subtitle = "Lunch"
        content.body = "Its lunch time at the park, please join us for a dinosaur feeding"
        let sound = UNNotificationSound(named: UNNotificationSoundName(rawValue: "carhorn.wav"))
        content.sound = sound
        content.categoryIdentifier = CategoryIdentifiers.general

        if let url = Bundle.main.url(forResource: "jurassic_world", withExtension: "png") {
            if let attachment = try? UNNotificationAttachment(identifier: "image", url: url, options: nil) {
                content.attachments = [attachment]
            }
        }
        return content
        
    }


}
