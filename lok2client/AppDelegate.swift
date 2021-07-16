import UIKit
import IQKeyboardManagerSwift


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate
{
    static var gi:AppDelegate!
    var window: UIWindow?
    var nav_controller:BaseNavController!
    
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool
    {
        AppDelegate.gi = self
        IQKeyboardManager.shared.enable = true
        UNUserNotificationCenter.current().delegate = NotificationManager.gi
        
        window = UIWindow(frame: UIScreen.main.bounds)
        nav_controller = BaseNavController()
        window!.rootViewController = nav_controller
        window!.makeKeyAndVisible()
        //        var coordinator_auth = CoordinatorAuth(nav_controller: nav_controller)
        //        coordinator_auth.start()
        
        if(LocalData.getCurrentUser() != nil)
        {
            startMain()
        }
        else
        {
            startAuth()
        }
        
        runActionWithDelay(milliseconds: 30, action:
            {
                self.nav_controller.pushViewController(VcSplash(), animated: false)
        })
        
        
        return true
    }
    
    private func test()
    {
        let device = getDeviceName()
        print("Device is \(device)")
        
        let push_token = LocalData.getPushToken()
        print("Push token is \(push_token)")
    }
    
    func startAuth()
    {
//        nav_controller.viewControllers = []
        var coordinator_auth = CoordinatorAuth(nav_controller: nav_controller)
        coordinator_auth.toLogin()
    }
    
    func startMain()
    {
//        nav_controller.viewControllers = []
        var coordinator_main = CoordinatorMain(nav_controller: nav_controller)
        coordinator_main.toScreenMain()
    }
    
}

