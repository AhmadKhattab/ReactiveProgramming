//
//  SnackBarTestViewController.swift
//  SportsRxSwiftMVVM
//
//  Created by Ahmad Khattab on 25/04/2021.
//

import UIKit
import RxSwift
import RxCocoa

class SignupViewController: UIViewController {
    
    
    // Outlets
    @IBOutlet weak var emailTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var repasswordTextField: UITextField!
    @IBOutlet weak var signupButton: UIButton!
    @IBOutlet weak var errorLabel: UILabel!

    // Variables
    let disposeBag = DisposeBag()
    
    open override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
        setupValidationObservation()
        setupObservation()
        
    }
    
    let signupViewModel = SignupViewModel()
    
    
    fileprivate func setupObservation() {
        
        emailTextField.rx.controlEvent(.editingChanged)
            .throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe { _ in
                self.signupViewModel.email = self.emailTextField.text ?? ""
            } .disposed(by: disposeBag)
        
        passwordTextField.rx.controlEvent(.editingChanged)
            .throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe { _ in
                self.signupViewModel.password = self.passwordTextField.text ?? ""
            } .disposed(by: disposeBag)
        
        repasswordTextField.rx.controlEvent(.editingChanged)
            .throttle(.milliseconds(100), scheduler: MainScheduler.instance)
            .subscribe { _ in
                self.signupViewModel.repassword = self.repasswordTextField.text ?? ""
            } .disposed(by: disposeBag)
    }
    
    
    fileprivate func setupValidationObservation() {
        
        
        
        signupViewModel.validationPublisher.subscribe { (isValid) in

            if let isEnabled = isValid.element {
                self.toggleSigninButton(isEnabled: isEnabled)
            }

        }.disposed(by: disposeBag)
        
        
    }
    
    func setupView() {
        toggleSigninButton(isEnabled: false)
    }
    
    
    fileprivate func toggleSigninButton(isEnabled: Bool) {
        
        if isEnabled {
            
            signupButton.backgroundColor = #colorLiteral(red: 1, green: 0.4099907875, blue: 0, alpha: 1)
            signupButton.isEnabled = true
            
        } else {
            
            signupButton.backgroundColor = #colorLiteral(red: 0.2549019754, green: 0.2745098174, blue: 0.3019607961, alpha: 1)
            signupButton.isEnabled = false
        }
       
    }
    
    
    @objc
    fileprivate func signup() {
        
        print("i like when u touch me there!")
        
    }
}

