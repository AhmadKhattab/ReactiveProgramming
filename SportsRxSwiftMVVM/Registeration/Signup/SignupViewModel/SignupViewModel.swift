//
//  SignupViewModel.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 28/04/2021.
//

import Foundation
import RxSwift
import RxCocoa

class SignupViewModel {
    
    @Email
    var email {
        
        didSet {
            validate()
        }
        
    }
    
    
    @Password
    var password {
        
        didSet {
            validate()
        }
    }
    
    @Password
    var repassword {
        
        didSet {
            validate()
        }
    }
    
    var validationPublisher = PublishSubject<Bool>()
    var passwordMismatchPublisher = PublishSubject<Bool>()
    
    
    fileprivate func validate() {

            let isValid = [email, password, repassword].map { $0 != nil }.reduce(true) { (result, item) -> Bool in
                
                result && item
            }
            
            validationPublisher.onNext(isValid)
        
    }
    
}


@propertyWrapper
struct Email {
    
    var value: String? = ""
    var wrappedValue: String? {
        
        
        get {
            guard let value = value else { return nil }
            return validate(email: value) ? value : nil
        }
        
        set {
            
            value = newValue
        }
    }
    
    private func validate(email: String?) -> Bool {
        guard let email = email else { return false }
        let emailRegEx = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let emailPred = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailPred.evaluate(with: email)
    }
}

@propertyWrapper
struct Password {
    
    var value: String? = ""
    var wrappedValue: String? {
        
        
        get {
            guard let value = value else { return nil }
            return value.isEmpty || value.count < 9 ? nil : value
        }
        
        set {
            
            value = newValue
        }
    }
}


class LiveData<T> {
    
    
    typealias Listener = (T) -> Void
    
    var listener: Listener?
    
    var value: T? {
        
        didSet {
            
            guard let value = value else {return}
            
            listener?(value)
        }
    }
    
    
    init(value: T?) {
        self.value = value
    }
    
    
    func bind(listener: @escaping Listener) {
        
        self.listener = listener
        
        guard let value = value else { return }
        
        self.listener?(value)
    }
}
