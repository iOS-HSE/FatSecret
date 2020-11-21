import UIKit

class AuthViewModel: BaseViewModel {
    
    typealias Command = AuthCommand
    
    var emailAuthResult: Observable<Bool> = Observable()
    
    var phoneAuthResult: Observable<Bool> = Observable()
    
    private var authRepository: IAuthRepository? = nil
    
    init(authRepository: IAuthRepository) {
        self.authRepository = authRepository
    }
    
    func sendCommand(command: Command) {
        switch command {
        case .EmailAuth(let email, let password):
            handleEmailAuth(email, password)
        case .PhoneAuth(let phoneNumber):
            handlePhoneAuth(phoneNumber)
        }
    }
    
    private func handleEmailAuth(_ email: String, _ password: String) {
        emailAuthResult.value((authRepository?.emailLogIn(email: email, password: password)) ?? false)
    }
    
    private func handlePhoneAuth(_ phoneNumber: String) {
        phoneAuthResult.value((authRepository?.phoneLogIn(phoneNumber: phoneNumber)) ?? false)
    }
}

enum AuthCommand {
    case EmailAuth(email: String, password: String)
    case PhoneAuth(phoneNumber: String)
}

protocol BaseViewModel {
    associatedtype Command
    
    var emailAuthResult: Observable<Bool> { get }
    
    var phoneAuthResult: Observable<Bool> { get }
    
    func sendCommand(command: Command)
}

class Observable<T> {
    
    private var value: T?
    
    func value(_ value: T) {
        self.value = value
    }
    
    func observe(action: (T) -> Unit) {
        action(value!)
    }
}
