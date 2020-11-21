import FirebaseAuth

class AuthRepository: IAuthRepository {
    
    private var someDependency: SomeDependency? = nil
    
    init(someDependency: SomeDependency) {
        self.someDependency = someDependency
    }
    
    func emailLogIn(email: String, password: String) -> Bool {
        FirebaseAuth.Auth.auth().signIn(withEmail: email, password: password, completion: { [weak self] result, error in
            guard self != nil else {
                return
            }
        })
        return true
    }
    
    func phoneLogIn(phoneNumber: String) -> Bool {
        return true
    }
    
}


protocol IAuthRepository {
    func emailLogIn(email: String, password: String) -> Bool
    func phoneLogIn(phoneNumber: String) -> Bool
}
