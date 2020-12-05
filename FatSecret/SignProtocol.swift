import UIKit
import Firebase

extension UIViewController {

    func authErrorAlert(_ error: Error) {
        
        let alert = UIAlertController(title: "Authorization error", message: error.localizedDescription, preferredStyle: .alert)
        
        alert.addAction(UIAlertAction(title: "OK", style: .default))
        
        self.present(alert, animated: true, completion: nil)
    }
    
}
