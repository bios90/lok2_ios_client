import Foundation
import RxSwift
import RxCocoa

class BaseVm
{
    var dispose_bag = DisposeBag()
    var base_networker : BaseNetworker!
    var ps_dissmiss_vc : PublishSubject<Bool> = PublishSubject.init()
    var ps_to_send_email:PublishSubject<MailData> = PublishSubject.init()
    var ps_to_open_pdf:PublishSubject<String> = PublishSubject.init()
    
    init()
    {
        base_networker = BaseNetworker(base_vm: self)
    }
    
}

//MARK: -Pdf Opening
extension BaseVm
{
    func clickedDocument(document:ModelDocument)
    {
        var btns:[BtnAction] = []
        
        if(document.url_pdf != nil)
        {
            let btn = BtnAction(text: "Pdf", action:
            { _ in
                
                self.clickedToShowPdf(document: document)
            })
            btns.append(btn)
        }
        
        if(document.url_video != nil)
        {
            let btn = BtnAction(text: "Видео", action:
            { _ in
                
                openUrlInBrowser(url_str: document.url_video!)
            })
            btns.append(btn)
        }
        
        if(document.url_html != nil)
        {
            let btn = BtnAction(text: "Ссылка", action:
            { _ in
                
                openUrlInBrowser(url_str: document.url_html!)
            })
            btns.append(btn)
        }
        
        guard let document_id = document.id else { return }
        
        if(LocalData.haveInFavorites(id: document_id))
        {
            let btn = BtnAction(text: "Удалить из избранного", action:
            { _ in
                
                LocalData.removeFromFavorites(id: document_id)
                MessagesManager.showGreenAlerter(text: "Удалено из избранного")
            })
            btns.append(btn)
        }
        else
        {
            let btn = BtnAction(text: "Добавить в избранное", action:
            { _ in
                
                LocalData.saveToFavorites(id: document_id)
                MessagesManager.showGreenAlerter(text: "Добавлено в избранное")
            })
            btns.append(btn)
        }
        
        let btn = BtnAction(text: "Задать вопрос", action:
        { _ in
            
            let email = "ilyaevdokimovauditorapp@gmail.com"
            let subj = "Вопрос из приложения хронос"
            let user_name = LocalData.getCurrentUser()?.getFullName() ?? ""
            let text = "Пользователь: \(user_name)\nДокумент: \(document.title ?? "")"
            
            let mail_data = MailData(email_to: email, subject: subj, text: text)
            self.ps_to_send_email.onNext(mail_data)
        })
        btns.append(btn)
        
        MessagesManager.showBottomDefault(title: document.title, text: nil, btns: btns, vc: nil)
    }
    
    func clickedToShowPdf(document:ModelDocument)
    {
        guard let pdf_url = document.url_pdf else { return }
        
        let action_download =
        {
            self.base_networker.downloadFile(url: pdf_url, action_success:
                { _ in
                    
                    self.clickedToShowPdf(document: document)
            })
        }
        let file_name = (pdf_url as NSString).lastPathComponent
        
        
        let path = NSSearchPathForDirectoriesInDomains(.documentDirectory, .userDomainMask, true)[0] as String
        let url = NSURL(fileURLWithPath: path)
        if let file_path = url.appendingPathComponent(file_name) {
            let path = file_path.path
            let fileManager = FileManager.default
            if fileManager.fileExists(atPath: path)
            {
                self.ps_to_open_pdf.onNext(path)
            }
            else
            {
                action_download()
            }
        }
        else
        {
            action_download()
        }
    }
}
