import UIKit

class StartViewController: UIViewController {
    
    private let MAIN_SCREEN_IDENTIFIER: String = "MainScreen"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    func goToMain(){
        let newViewController = (storyboard?.instantiateViewController(withIdentifier: MAIN_SCREEN_IDENTIFIER ))!
        self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        guard let uid = UserDefaults.standard.string(forKey: "uid") else { return }
        Storage.userID = uid
        Storage.fetchDataFromFirestore(completion: goToMain)
    }

}
