import UIKit
import RxSwift
import RxCocoa
import Alamofire

extension Observable where Element == AFDataResponse<Data?>
{
    func addMyParser<T:BaseResponse>(type:T.Type) -> Observable<T>
    {
        self.map(
            { response in
                
                if let err = response.error
                {
                    if  let url_err = err as? URLError, url_err.code  == URLError.Code.notConnectedToInternet
                    {
                        throw RequestError.ErrConnection
                    }
                    
                    throw err
                }
                
                guard let data = response.data else
                {
                    throw RequestError.ErrUnknown
                }
                
                let str = String(decoding: data, as: UTF8.self)
                
                print(str)
                
                if(str.contains("\"email_occupied\":true"))
                {
                    throw RequestError.ErrEmailOccupied
                }
                
                guard let base_response = try? JSONDecoder().decode(BaseResponse.self, from: data) else { throw RequestError.ErrJsonDecode }
                
                if let error = base_response.getError()
                {
                    throw error
                }
                
                guard let obj = try? JSONDecoder().decode(T.self, from: data) else { throw RequestError.ErrJsonDecode }
                
                return obj
        })
    }
}
