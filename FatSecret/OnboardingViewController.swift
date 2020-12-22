import UIKit
import paper_onboarding

let background = UIColor(red: 253/255, green: 196/255, blue: 70/255, alpha: 1)

let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!

let descriptionFont = UIFont(name: "AvenirNext-Bold", size: 18)!

class OnboardingViewController: UIViewController {
    
    private let START_SCREEN_IDENTIFIER: String = "StartScreen"
    
    let screens = [
            OnboardingItemInfo(
                informationImage: UIImage(systemName: "star.fill")!,
                title: "Calc your expenses",
                description: "Icing lemon drops tootsie roll sugar plum. Cheesecake biscuit cupcake chocolate bar pudding chocolate cake. Danish donut sweet toffee.",
                pageIcon: UIImage(systemName: "star.fill")!,
                color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
            ),
            OnboardingItemInfo(
                informationImage: UIImage(systemName: "star.fill")!,
                title: "Learn you expenses",
                description: "Icing lemon drops tootsie roll sugar plum. Cheesecake biscuit cupcake chocolate bar pudding chocolate cake. Danish donut sweet toffee.",
                pageIcon: UIImage(systemName: "star.fill")!,
                color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
            ),
            OnboardingItemInfo(
                informationImage: UIImage(systemName: "star.fill")!,
                title: "Achive your goals",
                description: "Icing lemon drops tootsie roll sugar plum. Cheesecake biscuit cupcake chocolate bar pudding chocolate cake. Danish donut sweet toffee.",
                pageIcon: UIImage(systemName: "star.fill")!,
                color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
            )
        ]

    override func viewDidLoad() {
        super.viewDidLoad()
        let onboarding = PaperOnboarding()
        onboarding.dataSource = self
        onboarding.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(onboarding)
        for attribute: NSLayoutConstraint.Attribute in [.left, .right, .top, .bottom] {
            let constraint = NSLayoutConstraint(item: onboarding,
                                                attribute: attribute,
                                                relatedBy: .equal,
                                                toItem: view,
                                                attribute: attribute,
                                                multiplier: 1,
                                                constant: 0)
            view.addConstraint(constraint)
          }
//        onboardingView.dataSource = self
//        onboardingView.delegate = self
    }
}

extension OnboardingViewController : PaperOnboardingDataSource, PaperOnboardingDelegate {
    
    public func onboardingItemsCount() -> Int {
        screens.count
    }
    
    public func onboardingItem(at index: Int) -> OnboardingItemInfo {
        return screens[index]
    }
    
    func onboardingConfigurationItem(_ item: OnboardingContentViewItem, index: Int) {
        
    }
    
//    func onboardingWillTransitonToIndex(_ index: Int) {
//        if index != screens.count - 1 {
//            UIView.animate(withDuration: 0.2, animations: {
//                self.getStartedButton.alpha = 0
//            })
//        }
//    }
//
//    func onboardingDidTransitonToIndex(_ index: Int) {
//        if index == screens.count - 1 {
//            UIView.animate(withDuration: 0.4, animations: {
//                self.getStartedButton.alpha = 1
//            })
//        }
//    }
}
