import Foundation

class Constants
{
    struct Urls
    {
        static let test_mode = false
        static let URL_BASE:String =
        {
            if(test_mode)
            {
                return "http://192.168.1.67/akcsl/"
            }
            
            return "https://ak-hr.ru/"
        }()
        
        static let REGISTER = "register"
        static let LOGIN = "login"
        static let FORGOT_PASS = "forgotpass"
        static let UPDATE_USER_INFO = "update_user_info"
        static let GET_CATEGORIES = "get_categories"
        static let GET_CATEGORIY_BY_ID = "get_category_by_id"
        static let GET_USER_BY_ID = "get_user_by_id"
        static let GET_DOCUMENTS = "get_documents"
        static let GET_DOCUMENT_BY_MULTI_IDS = "get_by_multi_ids"
    }
}
