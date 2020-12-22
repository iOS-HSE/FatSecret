import UIKit
import paper_onboarding

let background = UIColor(red: 249/255, green: 183/255, blue: 190/255, alpha: 1)

let titleFont = UIFont(name: "AvenirNext-Bold", size: 24)!

let descriptionFont = UIFont(name: "AvenirNext-Bold", size: 18)!

class OnboardingViewController: UIViewController {
    
    private let START_SCREEN_IDENTIFIER: String = "StartScreen"
    
    let screens = [
            OnboardingItemInfo(
                informationImage: UIImage(systemName: "pencil")!,
                title: "Write that you eat",
                description: "Our application get possibilities to write and add to favorites your food",
                pageIcon: UIImage(systemName: "poweroff")!,
                color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
            ),
            OnboardingItemInfo(
                informationImage: UIImage(systemName: "paperplane")!,
                title: "Get information about food",
                description: "You can get knowledge about nutrion, vitamins and others microelements",
                pageIcon: UIImage(systemName: "poweroff")!,
                color: background, titleColor: UIColor.white, descriptionColor: UIColor.white, titleFont: titleFont, descriptionFont: descriptionFont
            ),
            OnboardingItemInfo(
                informationImage: UIImage(systemName: "star.fill")!,
                title: "Analyze data and build your diet!",
                description: "Calculate nutrients from your dishes and construct future diet and set futher plans",
                pageIcon: UIImage(systemName: "poweroff")!,
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
        let button = UIButton()
        button.frame = CGRect(x: self.view.frame.size.width - 280, y: self.view.frame.size.height - 250, width: 150, height: 50)
        button.backgroundColor = .systemBlue
        button.setTitle("Get started!", for: .normal)
        button.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
        view.addSubview(button)
    }
    
    @objc private func buttonAction(sender: UIButton!) {
        let newViewController = (storyboard?.instantiateViewController(withIdentifier: START_SCREEN_IDENTIFIER ))!
        self.present(newViewController, animated: true, completion: nil)
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
}
