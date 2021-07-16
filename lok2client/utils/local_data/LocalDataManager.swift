import Foundation

enum LocalKeys:String
{
    case PushToken
    case CurrentUser
    case UserFavorites
}

class LocalData
{
    static func savePushToken(token:String)
    {
        UserDefaults.standard.set(token, forKey: LocalKeys.PushToken.rawValue)
    }
    
    static func getPushToken()->String?
    {
        guard UserDefaults.standard.hasKey(key: LocalKeys.PushToken.rawValue)  else { return nil }
        
        return UserDefaults.standard.string(forKey: LocalKeys.PushToken.rawValue)
    }
    
    static func clearPushToken()
    {
        UserDefaults.standard.removeObject(forKey: LocalKeys.PushToken.rawValue)
    }
    
    static func saveCurrentUser(user:ModelUser)
    {
        let encoder = globalJsonEncoder
        if let encoded = try? encoder.encode(user)
        {
            UserDefaults.standard.set(encoded, forKey: LocalKeys.CurrentUser.rawValue)
        }
    }
    
    static func clearCurrentUser()
    {
        UserDefaults.standard.removeObject(forKey: LocalKeys.CurrentUser.rawValue)
    }
    
    static func getCurrentUser()->ModelUser?
    {
        if let data = UserDefaults.standard.object(forKey: LocalKeys.CurrentUser.rawValue) as? Data
        {
            let decoder = globalJsonDecoder
            
            if let user = try? decoder.decode(ModelUser.self, from: data)
            {
                return user
            }
        }
        
        return nil
    }
}

//MARK
extension LocalData
{
    static func saveToFavorites(id:Int)
    {
        let favorites = LocalData.getUserFavorites()
        let inserted = favorites.set.insert(id).inserted
        LocalData.saveUserFavorites(user_favorites: favorites)
        if(inserted == true)
        {
            BusMainEvents.gi.ps_user_favorites_changed.onNext(())
        }
    }
    
    static func haveInFavorites(id:Int)->Bool
    {
        let favorites = LocalData.getUserFavorites()
        let contains = favorites.set.contains(id)
        if(contains == true)
        {
            return true
        }
        
        return false
    }
    
    static func removeFromFavorites(id:Int)
    {
        let favorites = LocalData.getUserFavorites()
        let removed_element = favorites.set.remove(id)
        LocalData.saveUserFavorites(user_favorites: favorites)
        if removed_element != nil
        {
            BusMainEvents.gi.ps_user_favorites_changed.onNext(())
        }
    }
    
    static func saveUserFavorites(user_favorites:ModelUserFavorite)
    {
        let encoder = globalJsonEncoder
        if let encoded = try? encoder.encode(user_favorites)
        {
            UserDefaults.standard.set(encoded, forKey: LocalKeys.UserFavorites.rawValue)
        }
    }
    
    static func getUserFavorites()->ModelUserFavorite
    {
        if(!UserDefaults.standard.hasKey(key: LocalKeys.UserFavorites.rawValue))
        {
            saveUserFavorites(user_favorites: ModelUserFavorite())
        }
        
        if let data = UserDefaults.standard.object(forKey: LocalKeys.UserFavorites.rawValue) as? Data
        {
            let decoder = globalJsonDecoder
            
            if let user_favorites = try? decoder.decode(ModelUserFavorite.self, from: data)
            {
                return user_favorites
            }
        }
        
        fatalError("**** Error no user favorites ****")
    }
    
}
