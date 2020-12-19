import UIKit
import paper_onboarding

class OnboardingViewController: UIViewController {
    
    private let START_SCREEN_IDENTIFIER: String = "StartScreen"

    override func viewDidLoad() {
        super.viewDidLoad()
        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)

        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(
                item: onboarding,
                attribute: attribute,
                relatedBy: .equal,
                toItem: view,
                attribute: attribute,
                multiplier: 1,
                constant: 0
            )
            view.addConstraint(constraint)
        }
    }
    
    private func goToStartScreen() {
        let newViewController = (storyboard?.instantiateViewController(withIdentifier: START_SCREEN_IDENTIFIER ))!
        self.present(newViewController, animated: true, completion: nil)
    }
    
    func onboardingItem(at index: Int) -> OnboardingItemInfo {
        let image = UIImage(systemName: "arrow.uturn.up")!
    
        return [
            OnboardingItemInfo(informationImage: image,
                                       title: "title",
                                 description: "description",
                                    pageIcon: image,
                                    color: .black,
                                  titleColor: .black,
                            descriptionColor: .black,
                                   titleFont: .italicSystemFont(ofSize: 30.0),
                             descriptionFont: .italicSystemFont(ofSize: 30.0)),

            OnboardingItemInfo(informationImage: image,
                                        title: "title",
                                  description: "description",
                                     pageIcon: image,
                                        color: .black,
                                   titleColor: .black,
                             descriptionColor: .black,
                             titleFont: .italicSystemFont(ofSize: 30.0),
                              descriptionFont: .italicSystemFont(ofSize: 30.0)),

            OnboardingItemInfo(informationImage: image,
                                     title: "title",
                               description: "description",
                                  pageIcon: image,
                                     color: .black,
                                titleColor: .black,
                          descriptionColor: .black,
                                 titleFont: .italicSystemFont(ofSize: 30.0),
                           descriptionFont: .italicSystemFont(ofSize: 30.0))
         ][index]
     }

     func onboardingItemsCount() -> Int {
        return 3
     }
}
