import UIKit
import RxSwift
import RxCocoa
import MessageUI

class BaseViewController:UIViewController
{
    let dispose_bag = DisposeBag()
    var base_vm:BaseVm?
    var show_navbar = false
    var status_bar_style:UIStatusBarStyle = .lightContent
    
    var btn_left:UIBarButtonItem?
    var btn_left_my:BtnAction?
    
    func setBaseVmAction(base_vm:BaseVm)
    {
        self.base_vm = base_vm
        
        base_vm.ps_dissmiss_vc
            .subscribe(onNext:
                { animated in
                    
                    self.removeOrDismiss(animated: animated)
            }).disposed(by: dispose_bag)
        
        base_vm.ps_to_send_email
            .subscribe(onNext:
                { mail_data in
                    
                    self.sendEmail(mail_data: mail_data)
            })
            .disposed(by: dispose_bag)
        
        base_vm.ps_to_open_pdf
            .subscribe(onNext:
                { file_path in
                    
                    self.openPdf(file_path: file_path)
            })
            .disposed(by: dispose_bag)
    }
}
//MARK: -Lifecycle
extension BaseViewController
{
    override func viewWillAppear(_ animated: Bool)
    {
        super.viewWillAppear(animated)
        navigationController?.setNavigationBarHidden(!show_navbar, animated: animated)
        setNeedsStatusBarAppearanceUpdate()
    }
    
    override func viewWillDisappear(_ animated: Bool)
    {
        super.viewWillDisappear(animated)
        navigationController?.setNavigationBarHidden(!show_navbar, animated: animated)
    }
    
    override var preferredStatusBarStyle: UIStatusBarStyle
    {
        return status_bar_style
    }
}

//MARK: - Navbar and buttons
extension BaseViewController
{
    func setBtnLeft(btn:BtnAction,btn_color:UIColor = MyColors.gi.white)
    {
        self.btn_left = UIBarButtonItem(title: btn.text, style: .plain, target: self , action: #selector(clickedNavLeft))
        self.btn_left_my = btn
        btn_left?.tintColor = btn_color
        btn_left?.setFont(font: MyFonts.gi.reg_m)
        self.navigationItem.leftBarButtonItem = btn_left
        btn_left?.isEnabled = true
    }
    
    @objc func clickedNavLeft()
    {
        btn_left_my?.action(NSObject())
    }
}

//MARK: -Mailing
struct MailData
{
    let email_to:String
    let subject:String
    let text:String
}

extension BaseViewController:MFMailComposeViewControllerDelegate
{
    func sendEmail(mail_data:MailData)
    {
        if MFMailComposeViewController.canSendMail()
        {
            let mail = MFMailComposeViewController()
            mail.mailComposeDelegate = self
            mail.setToRecipients([mail_data.email_to])
            mail.setSubject(mail_data.subject)
            mail.setMessageBody(mail_data.text, isHTML: true)
            
            present(mail, animated: true)
        }
    }
    
    func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?)
    {
        controller.dismiss(animated: true)
    }
}

//MARK: -Pdf opening
extension BaseViewController:UIDocumentInteractionControllerDelegate
{    
    func openPdf(file_path:String)
    {
        let dc = UIDocumentInteractionController(url: URL(fileURLWithPath: file_path))
        dc.delegate = self
        dc.presentPreview(animated: true)
    }
    //MARK: UIDocumentInteractionController delegates
    func documentInteractionControllerViewControllerForPreview(_ controller: UIDocumentInteractionController) -> UIViewController
    {
        return self
    }
}
