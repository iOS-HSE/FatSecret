import UIKit

class StartViewController: UIViewController {
    
    private let MAIN_SCREEN_IDENTIFIER: String = "MainScreen"
    private let ONBOARDING_SCREEN_IDENTIFIER: String = "OnboardingScreen"
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
    private func goToMain() {
        let newViewController = (storyboard?.instantiateViewController(withIdentifier: MAIN_SCREEN_IDENTIFIER ))!
        self.present(newViewController, animated: true, completion: nil)
    }
    
    private func goToOnboarding() {
        let newViewController = (storyboard?.instantiateViewController(withIdentifier: ONBOARDING_SCREEN_IDENTIFIER ))!
        self.present(newViewController, animated: true, completion: nil)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        goToOnboarding() // for testing
        guard let uid = UserDefaults.standard.string(forKey: "uid") else {
            if UserDefaults.standard.bool(forKey: "isNotFirstEnter") == false {
//                UserDefaults.standard.set(true, forKey: "isNotFirstEnter")
                goToOnboarding()
            }
            return
        }
        Storage.userID = uid
        Storage.fetchDataFromFirestore(completion: goToMain)
    }

}
