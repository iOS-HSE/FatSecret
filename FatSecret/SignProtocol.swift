
import UIKit
import Firebase

protocol Signing {

    var NEXT_SCREEN_IDENTIFIER: String { get }
    
    var NEXT_SCREEN_TYPE: String { get }
    
    func authErrorAlert(_ error: Error)
    
    func authOnCompletion(result: AuthDataResult?, error: Error?)
    
}

extension UIViewController: Signing {
    
    @objc var NEXT_SCREEN_IDENTIFIER: String {
        ""
    }
    
    @objc var NEXT_SCREEN_TYPE: String {
        
    }

    func authErrorAlert(_ error: Error) {
        
        let alert = UIAlertController(title: "Authorization error", message: error.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
    
    func authOnCompletion(result: AuthDataResult?, error: Error?) {
        if (error != nil) {
            authErrorAlert(error!)
            return
        }
        let newViewController = storyboard?.instantiateViewController(withIdentifier: NEXT_SCREEN_IDENTIFIER ) as! MainViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
}

extension SignInViewController {
    @objc override var NEXT_SCREEN_IDENTIFIER: String {
        "MainScreen"
    }
}

extension SignUpViewController {
    @objc override var NEXT_SCREEN_IDENTIFIER: String {
        "SignIn"
    }
}
