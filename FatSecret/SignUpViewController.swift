import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    @IBAction func handleSignUpClick(_ sender: Any) {
        guard let login = loginField.text else { return }
        guard let password = passwordField.text else { return }
        Auth.auth().createUser(withEmail: login, password: password, completion: authOnCompletion)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    private func badAuthAlert(_ error: Error) {
//        let alert = UIAlertController(title: "Bad Auth", message: error.localizedDescription, preferredStyle: .alert)
//
//        alert.addAction(UIAlertAction(title: "OK", style: .default))
//
//        self.present(alert, animated: true, completion: nil)
//    }
//
//    private func signIn(result: AuthDataResult?, error: Error?) {
//        if (error != nil) {
//            badAuthAlert(error!)
//            return
//        }
//        let newViewController = storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
//        self.present(newViewController, animated: true, completion: nil)
//    }

}
