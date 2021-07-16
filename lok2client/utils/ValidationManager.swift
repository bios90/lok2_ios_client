import Foundation

class ValidationData
{
    var is_valid = true
    var errors:[String] = []
    
    func getErrorMessage() -> String
    {
        return listOfStringToSingle(strings:errors)
    }
    
    func validateNotNullString(str:String?,field_name:String,min_chars:Int?)
    {
        if(str.isNullOrEmpty())
        {
            is_valid = false
            errors.append(getPleaseFillFieldStr(field: field_name))
        }
        else if(min_chars != nil)
        {
            let min_chars = min_chars!
            if(str!.count < min_chars)
            {
                is_valid = false
                errors.append("Поле '\(field_name)' должно содержать минимум \(min_chars) символов")
            }
        }
    }
    
    func validateEmail(email:String?)
    {
        if(email.isNullOrEmpty())
        {
            is_valid = false
            errors.append(getPleaseFillFieldStr(field: "Email"))
        }
        else if(!isValidEmail(email!))
        {
            is_valid = false
            errors.append(MyString.enter_valid_email.localized())
        }
    }
    
    func validatePasswords(password_1: String?, password_2: String?)
    {
        if (password_1 == nil)
        {
            is_valid = false
            errors.append(getPleaseFillFieldStr(field: "Пароль"))
        }
        else if (password_1!.count < 8)
        {
            is_valid = false
            errors.append("Пароль должен содержать минимум 8 символов")
        }
        else if (password_2 == nil)
        {
            is_valid = false
            errors.append(getPleaseFillFieldStr(field: "Повторите пароль"))
        }
        else if (password_1 != password_2)
        {
            is_valid = false
            errors.append("Пароли не совпадают")
        }
    }
}

class ValidationManager
{
    static func validateRegister(first_name:String?,last_name:String?,email:String?,password1:String?,password2:String?)->ValidationData
    {
        let data = ValidationData()
        data.validateNotNullString(str: first_name, field_name: "Имя", min_chars: 2)
        data.validateNotNullString(str: last_name, field_name: "Фамилия", min_chars: 2)
        data.validateEmail(email: email)
        data.validatePasswords(password_1: password1, password_2: password2)
        return data
    }
    
    static func validateLogin(email:String?,password:String?)->ValidationData
    {
        let data = ValidationData()
        data.validateEmail(email: email)
        data.validateNotNullString(str: password, field_name: "Пароль", min_chars: 8)
        return data
    }
}

func getPleaseFillFieldStr(field:String)->String
{
    return "Пожалуйста заполните поле '\(field)'"
}

func isValidEmail(_ emailStr:String) -> Bool
{
    let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
    
    let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
    return emailPred.evaluate(with: emailStr)
}


