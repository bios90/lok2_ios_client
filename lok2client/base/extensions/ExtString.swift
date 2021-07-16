import Foundation

extension Optional where Wrapped == String
{
    func getNullable() -> String?
    {
        if(self == nil)
        {
            return nil
        }
        
        let text = self?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(text!.isEmpty)
        {
            return nil
        }
        
        return text
    }
    
    func getNullableAndTrimmed() -> String?
    {
        if(self == nil)
        {
            return nil
        }
        
        let text = self?.trimmingCharacters(in: .whitespacesAndNewlines)
        
        if(text!.isEmpty)
        {
            return nil
        }
        
        return text
    }
    
    func isNullOrEmpty()->Bool
    {
        let trimmed = self.getNullableAndTrimmed()
        return trimmed == nil
    }
}
