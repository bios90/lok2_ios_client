import Foundation
import Alamofire
import RxSwift
import RxCocoa

class MyRequest
{
    var base_url = Constants.Urls.URL_BASE
    var method:HTTPMethod = .get
    var path:String = ""
    var parameters: [String : String?] = [:]
    var file_download_url:String!
    
    func getParamsWithoutNil()->[String:String]
    {
        var parameters_filtered: [String:String] = [:]
        parameters.forEach{ if $1 != nil { parameters_filtered[$0] = $1! } }
        return parameters_filtered
    }
    
    static func getHeaders()->HTTPHeaders
    {
        var headers:HTTPHeaders =
            [
                "Accept": "application/json",
                "App-Env": "ios"
        ]
        
        return headers
    }
}

//MARK: -For Networking
extension MyRequest
{
    func toObservable() ->Observable<AFDataResponse<Data?>>
    {
        let url = self.base_url+self.path
        
        print("Will make request to url \n\n\n ***** \(url) ***** \n\n\n")
        
        return Observable<AFDataResponse<Data?>>.create
            {  observer in
                
                let request = AF.request(url,method: self.method,parameters: self.getParamsWithoutNil(),headers: MyRequest.getHeaders())
                    .response(completionHandler:
                        { response in
                            
                            observer.onNext(response)
                            observer.onCompleted()
                    })
//                    .cURLDescription(calling:
//                        { curl in
//                            
//                            print(curl)
//                    })
                
                return Disposables.create
                    {
                        request.cancel()
                }
        }
    }
    
    func toObservableFileDownload() -> Observable<String?>
    {
        let url = self.file_download_url!
        print("url to download is \(url)")
        
        let file_name = (url as NSString).lastPathComponent
        
        let destination: DownloadRequest.Destination = { _, _ in
            let documentsURL = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0]
            let fileURL = documentsURL.appendingPathComponent(file_name)
            
            return (fileURL, [.removePreviousFile, .createIntermediateDirectories])
        }
        
        return Observable<String?>.create
            {  observer in
                
                let request = AF.download(
                    url,
                    method: .get,
                    encoding: JSONEncoding.default,
                    headers: nil,
                    to: destination)
                    .downloadProgress(closure: { (progress) in
                        
                    }).response(completionHandler: { response in
                        
                        print("error is \(response.error)")
                        if let file_url = response.fileURL
                        {
                            observer.onNext(file_url.absoluteString)
                            observer.onCompleted()
                        }
                        else
                        {
                            observer.onError(RequestError.ErrUnknown)
                        }
                    })
                
                return Disposables.create {
                    request.cancel()
                }
        }
    }
}

//MARK: - requests list
extension MyRequest
{
    static func getReqRegister(first_name:String,last_name:String,email:String,password:String,avatar:String?)->MyRequest
    {
        let req = MyRequest()
        req.method = .post
        req.path = Constants.Urls.REGISTER
        req.parameters =
            [
                "first_name" : first_name,
                "last_name" : last_name,
                "email" : email,
                "password" : password,
                "avatar" : avatar
        ]
        
        return req
    }
    
    static func getReqLogin(email:String,password:String,push_token:String?)->MyRequest
    {
        let req = MyRequest()
        req.method = .post
        req.path = Constants.Urls.LOGIN
        req.parameters =
            [
                "email" : email,
                "password" : password,
                "fb_token" : push_token,
                "env" : "ios",
                "device_name" : getDeviceName()
        ]
        
        return req
    }
    
    static func getReqPassRecover(email:String)->MyRequest
    {
        let req = MyRequest()
        req.method = .post
        req.path = Constants.Urls.FORGOT_PASS
        req.parameters =
            [
                "email" : email
        ]
        
        return req
    }
    
    static func getAllCategories()->MyRequest
    {
        let req = MyRequest()
        req.method = .get
        req.path = Constants.Urls.GET_CATEGORIES
        req.parameters = [:]
        
        return req
    }
    
    static func getDocuments(category_id:Int?,search:String?)->MyRequest
    {
        let req = MyRequest()
        req.method = .get
        req.path = Constants.Urls.GET_DOCUMENTS
        req.parameters =
            [
                "search" : search
        ]
        
        if let category_id = category_id
        {
            req.parameters["category_id"] = String(category_id)
        }
        
        return req
    }
    
    static func getCategoryById(category_id:Int)->MyRequest
    {
        let req = MyRequest()
        req.method = .get
        req.path = Constants.Urls.GET_CATEGORIY_BY_ID
        req.parameters =
            [
                "category_id" : String(category_id)
        ]
        
        return req
    }
    
    static func getFileDownloadRequest(url_str:String)->MyRequest
    {
        let req = MyRequest()
        req.method = .get
        req.file_download_url = url_str
        
        return req
    }
    
    static func getFavorites(ids_as_str:String)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.GET_DOCUMENT_BY_MULTI_IDS
        req.method = .get
        req.parameters =
            [
                "ids" : ids_as_str
        ]
        
        return req
    }
    
    static func getUserById(user_id:Int)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.GET_USER_BY_ID
        req.method = .get
        req.parameters =
            [
                "user_id" : String(user_id)
        ]
        
        return req
    }
    
    static func getReqUpdategUser(user_id:Int,first_name:String?,last_name:String?,password:String?,avatar:String?)->MyRequest
    {
        let req = MyRequest()
        req.path = Constants.Urls.UPDATE_USER_INFO
        req.method = .post
        req.parameters =
            [
                "user_id" : String(user_id),
                "first_name" : first_name,
                "last_name" : last_name,
                "password" : password,
                "avatar" : avatar
        ]
        
        return req
    }
}

