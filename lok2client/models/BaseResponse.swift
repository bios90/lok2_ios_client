import Foundation

class BaseResponse
{
    var status:TypeResponseStatus = .Error
    var errors:[String]? = nil
    
    func isFailed()->Bool
    {
        return self.status == .Success
    }
    
    func getErrorMessage()->String
    {
        
    }
}
