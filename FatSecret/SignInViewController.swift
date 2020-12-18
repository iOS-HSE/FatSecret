import UIKit
import Firebase
import FatSecretSwift

class SignInViewController: UIViewController {
        
    private let MAIN_SCREEN_IDENTIFIER: String = "MainScreen"

    @IBOutlet weak var passwordField: UITextField!
    @IBOutlet weak var loginField: UITextField!

    @IBAction func clickToEnter(_ sender: Any) {
        guard let login = loginField.text else { return }
        guard let password = passwordField.text else { return }
        Auth.auth().signIn(withEmail: login, password: password, completion: goToMainScreen)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func goToMainScreen(result: AuthDataResult?, error: Error?) {
        if (error != nil) {
            authErrorAlert(error!)
            return
        }
        Storage.userID = result?.user.uid
        Storage.updateDataFromFirestore()
        let newViewController = (storyboard?.instantiateViewController(withIdentifier: MAIN_SCREEN_IDENTIFIER ))!
        self.present(newViewController, animated: true, completion: nil)
    }

}
