import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {
    
    private let SIGN_IN_SCREEN_INDETIFIER = "SignIn"
    
    private var loginValue: String? = nil
    private var passwordValue: String? = nil

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func handleSignUpClick(_ sender: Any) {
        guard let login = loginField.text else { return }
        guard let password = passwordField.text else { return }
        loginValue = login
        passwordValue = password
        Auth.auth().createUser(withEmail: login, password: password, completion: goToSignInScreen)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func goToSignInScreen(result: AuthDataResult?, error: Error?) {
        if (error != nil) {
            authErrorAlert(error!)
            return
        }
        let newViewController = storyboard?.instantiateViewController(withIdentifier: SIGN_IN_SCREEN_INDETIFIER) as! SignInViewController
        newViewController.login = loginValue ?? ""
        newViewController.password = passwordValue ?? ""
        loginValue = nil
        passwordValue = nil
        self.present(newViewController, animated: true, completion: nil)
    }

}
