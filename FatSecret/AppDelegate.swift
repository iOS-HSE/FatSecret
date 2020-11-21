import UIKit
import Firebase
import Swinject

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var container = Container()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        FirebaseApp.configure()
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
    }

    private func registerDependencies() {
        
        self.container.register(SomeDependency.self) { _ in
            return SomeDependency()
        }
        
        self.container.register(IAuthRepository.self) { resolver in
            let someDependency = resolver.resolve(SomeDependency.self)!
            return AuthRepository(someDependency: someDependency)
        }
        self.container.register(AuthViewModel.self) { resolver in
            let authRepository = resolver.resolve(IAuthRepository.self)!
            return AuthViewModel(authRepository: authRepository)
        }
    }
}
