//
//  SignUpViewController.swift
//  FatSecret
//
//  Created by user184905 on 12/2/20.
//

import UIKit
import FirebaseAuth

class SignUpViewController: UIViewController {

    @IBOutlet weak var loginField: UITextField!
    @IBOutlet weak var passwordField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    private func badAuthAlert(){
        let alert = UIAlertController(title: "Bad Auth", message: "not sign up", preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: NSLocalizedString("OK", comment: "OK"), style: .default, handler: { _ in
        NSLog("The \"OK\" alert occured.")
        }))
        self.present(alert, animated: true, completion: nil)
    }
    
    private func toSignIn(result: AuthDataResult?, error: Error?){
        guard let _ = error else {return badAuthAlert()}
        let newViewController = storyboard?.instantiateViewController(withIdentifier: "SignIn") as! SignInViewController
        self.present(newViewController, animated: true, completion: nil)
    }
    
    @IBAction func clickSignUp(_ sender: Any) {
        guard let login = loginField.text else { return }
        guard let password = passwordField.text else { return }
        Auth.auth().createUser(withEmail: login, password: password, completion: toSignIn)
    }

}
