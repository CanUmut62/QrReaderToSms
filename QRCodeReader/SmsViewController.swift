
import UIKit
import MessageUI

class SmsViewController: UIViewController, MFMessageComposeViewControllerDelegate {
    @IBOutlet weak var extractedQRValueTextView: UITextView!
    @IBOutlet weak var phoneNumberTextField: UITextField!
    
    var extractedQRValue : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        initializeHideKeyboard()
        extractedQRValueTextView.text = extractedQRValue
    }
    
    func messageComposeViewController(_ controller: MFMessageComposeViewController, didFinishWith result: MessageComposeResult) {
        self.dismiss(animated: true, completion: nil)
    }

    @IBAction func sendButtonClicked(_ sender: Any) {
        if (phoneNumberTextField.text == nil || phoneNumberTextField.text!.isEmpty ) {
            let alertController = UIAlertController(title: "Hata", message: "Lütfen geçerli bir numara giriniz", preferredStyle: .alert)
            let alertAction = UIAlertAction(title: "Tamam", style: .default)
            alertController.addAction(alertAction)
            self.present(alertController, animated: true)
            return
        }
        if (MFMessageComposeViewController.canSendText()) {
            let controller = MFMessageComposeViewController()
            controller.body = extractedQRValue ?? "Değer okunamadı"
            controller.recipients = [phoneNumberTextField.text!]
            controller.messageComposeDelegate = self
            self.present(controller, animated: true, completion: nil)
        }
    }
    
    func initializeHideKeyboard(){
        let tap: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(dismissMyKeyboard))
        view.addGestureRecognizer(tap)
    }
    
    @objc func dismissMyKeyboard() {
        view.endEditing(true)
    }
    
}

