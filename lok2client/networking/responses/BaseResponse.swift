import Foundation

class BaseResponse:Decodable
{
    var status:TypeResponseStatus = .Failed
    var errors:[String]? = nil
    
    func isFailed()->Bool
    {
        return self.status == .Failed
    }
    
    func isSuccess() -> Bool
    {
        return status == .Success
    }
    
    func getErrorMessage()->String
    {
        if self.errors == nil || self.errors!.isEmpty
        {
            return "Неизвестная ошибка"
        }
        
        return listOfStringToSingle(strings: self.errors!)
    }
    
    func getError()->RequestError?
    {
        if(self.isSuccess())
        {
            return nil
        }
        
        if let errors = self.errors,errors.count > 0
        {
            print("Will return server error")
            let message = listOfStringToSingle(strings: errors)
            return RequestError.ErrServerFailed(message: message)
        }
        
        return RequestError.ErrUnknown
    }
}
