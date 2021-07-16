import Foundation

class DateManager
{
    static let FORMAT_FOR_SERVER_LARAVEL = "yyyy-MM-dd HH:mm:ss"
    static let FORMAT_FOR_DISPLAY = "dd MMM yyyy"
    
    static let ALL_FORMATS =
        [
            FORMAT_FOR_SERVER_LARAVEL,
            FORMAT_FOR_DISPLAY
    ]
}
