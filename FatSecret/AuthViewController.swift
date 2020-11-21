import UIKit

class AuthViewController: UIViewController {
    
    private let viewModel: AuthViewModel

    @IBOutlet weak var emailTextField: UITextField!
    
    @IBOutlet weak var passwordTextField: UITextField!
    
    @IBAction func logInBtnClicked(_ sender: Any) {
        let email = emailTextField.text ?? ""
        let password = passwordTextField.text ?? ""
        viewModel.sendCommand(command: AuthCommand.EmailAuth(email: email, password: password))
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        viewModel.emailAuthResult.observe(action: emailAuthObserve)
    }
    
    private func emailAuthObserve(success: Bool) -> Unit {
        if (success) {
            presentAlert(message: "Email auth success")
        } else {
            presentAlert(message: "Email auth failed")
        }
    }
    
    private func presentAlert(message: String) {
        let alert = UIAlertController(title: "Alert", message: message, preferredStyle: .alert)
        let okAction = UIAlertAction(title: "Ok", style: .default)
        alert.addAction(okAction)
        self.present(alert, animated: true)
    }
}
