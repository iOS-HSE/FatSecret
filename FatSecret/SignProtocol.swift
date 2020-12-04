
import UIKit
import Firebase

protocol Signing {
    
    associatedtype NextScreenType

    var NEXT_SCREEN_IDENTIFIER: String { get }
    
//    var NEXT_SCREEN_TYPE: NextScreenType { get }
    
    func authErrorAlert(_ error: Error)
    
    func authOnCompletion(result: AuthDataResult?, error: Error?)
    
}

extension UIViewController: Signing {
    
    typealias NextScreenType = MainViewController
    
    @objc var NEXT_SCREEN_IDENTIFIER: String {
        ""
    }
    
//    @objc var NEXT_SCREEN_TYPE: UIViewController.Type {
//        MainViewController.self
//    }

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
        let newViewController = storyboard?.instantiateViewController(withIdentifier: NEXT_SCREEN_IDENTIFIER ) as! NextScreenType
        self.present(newViewController, animated: true, completion: nil)
    }
    
}

extension SignInViewController {
    
    typealias NextScreenType = MainViewController
    
    @objc override var NEXT_SCREEN_IDENTIFIER: String {
        "MainScreen"
    }
    
//    @objc override var NEXT_SCREEN_TYPE: UIViewController.Type {
//        MainViewController.self
//    }
}

extension SignUpViewController {
    
    typealias NextScreenType = SignInViewController
    
    @objc override var NEXT_SCREEN_IDENTIFIER: String {
        "SignIn"
    }
    
//    @objc override var NEXT_SCREEN_TYPE: UIViewController.Type {
//        SignInViewController.self
//    }
}
