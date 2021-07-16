import UIKit
import UserNotifications

class NotificationManager:NSObject,UNUserNotificationCenterDelegate
{
    static var gi = NotificationManager()
    
    override init()
    {
        super.init()
        registerForPushNotifications()
    }
    
    func registerForPushNotifications()
    {
        UNUserNotificationCenter.current()
            .requestAuthorization(options: [.alert, .sound, .badge])
            {  granted, error in
                
                print("Permission granted: \(granted)")
                guard granted else { return }
                self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings()
    {
        UNUserNotificationCenter.current().getNotificationSettings
            { settings in
                
                guard settings.authorizationStatus == .authorized else { return }
                DispatchQueue.main.async
                    {
                        UIApplication.shared.registerForRemoteNotifications()
                }
        }
    }
    
    func application(_ application: UIApplication,didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data)
    {
        print("Got register answer!!!")
        let tokenParts = deviceToken.map { data in String(format: "%02.2hhx", data) }
        let token = tokenParts.joined()
        
        print("Got push token \(token )")
        LocalData.savePushToken(token: token)
        
    }
    
    func application(_ application: UIApplication, didFailToRegisterForRemoteNotificationsWithError error: Error)
    {
        print("Error on register to remote \(error)")
    }
}
