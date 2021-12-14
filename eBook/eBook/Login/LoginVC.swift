//
//  LoginVC.swift
//  eBook
//
//  Created by Fno Khalid on 18/04/1443 AH.
//

import UIKit
import FirebaseAuth
import Firebase
import AVFoundation
import TransitionButton
import FirebaseFirestore


class LoginVC: UIViewController, UITextFieldDelegate {
    
    lazy var logoImage: UIImageView = {
        let logo = UIImageView()
        logo.image = UIImage(named: "icon")
        logo.translatesAutoresizingMaskIntoConstraints = false
        logo.layer.cornerRadius = 25
        logo.isUserInteractionEnabled = true
        
        return logo
    }()
    
    let segmentedControl = UISegmentedControl()
    
    lazy var nameTF: UITextField = {
     let name = UITextField()
      name.placeholder = NSLocalizedString("write", comment: "")
      name.textAlignment = .center
      name.translatesAutoresizingMaskIntoConstraints = false
      name.textColor = UIColor(named: "textColor")
      name.font = UIFont.systemFont(ofSize: 14)
      name.backgroundColor = .lightGray
      name.layer.cornerRadius = 8
        
        return name
    }()

    
    var emailTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.backgroundColor = .lightGray
        tf.textAlignment = .center
        tf.layer.cornerRadius = 8
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = UIColor(named: "textColor")
        tf.attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("email", comment: ""),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
        tf.isSecureTextEntry = false
     //   tf.placeholder.color

        return tf
    }()
    
    var passwordTF: UITextField = {
        let tf = UITextField()
        tf.translatesAutoresizingMaskIntoConstraints = false
        tf.isSecureTextEntry = true
        tf.textAlignment = .center
        tf.backgroundColor = .lightGray
        tf.font = UIFont.systemFont(ofSize: 14)
        tf.textColor = UIColor(named: "textColor")
        tf.layer.cornerRadius = 8
        tf.attributedPlaceholder = NSAttributedString(
            string: NSLocalizedString("password", comment: ""),
            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])

        return tf
    }()
    
    lazy var confTF:  UITextField = {
          let conf = UITextField()
         conf.placeholder = NSLocalizedString("conf", comment: "")
         conf.textAlignment = .center
         conf.translatesAutoresizingMaskIntoConstraints = false
         conf.textColor = UIColor(named: "textColor")
         conf.font = UIFont.systemFont(ofSize: 14)
         conf.backgroundColor = .lightGray
         conf.layer.cornerRadius = 8
        
        return conf
        
      }()

    let logInButton : TransitionButton = {
        let btn = TransitionButton()
        btn.setTitle("LogIn", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        btn.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
      return btn
    }()
      
    let signUp : TransitionButton = {
        let btn = TransitionButton()
        btn.setTitle("Sign Up", for: .normal)
        btn.titleLabel?.font = UIFont.boldSystemFont(ofSize: 22)
        btn.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
        btn.layer.cornerRadius = 15
        btn.tintColor = .white
        btn.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)
      return btn
    }()
      
    
    
  override func viewDidLoad() {
    super.viewDidLoad()
      
      setupUI()
      self.nameTF.delegate = self
      self.emailTF.delegate = self
      self.passwordTF.delegate = self
      self.confTF.delegate = self
     
  }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
           nameTF.resignFirstResponder()
           emailTF.resignFirstResponder()
           passwordTF.resignFirstResponder()
           confTF.resignFirstResponder()

                  return true
          }
 
  let stackView : UIStackView = {
    $0.translatesAutoresizingMaskIntoConstraints = false
    $0.axis = .vertical
    $0.distribution = .fillEqually
    $0.spacing = 15
    return $0
  }(UIStackView())
    
        @objc func loginBtnPressed() {
                let email = emailTF.text ?? ""
                let password = passwordTF.text ?? ""
                if email.isEmpty || password.isEmpty {
                  return
                }
                Auth.auth().signIn(withEmail: email, password: password) { result, error in
                  if error != nil {
                    print(error as Any)
                    return
                  }
            self.logInButton.startAnimation()
            DispatchQueue.main.asyncAfter(deadline: .now()+1) {
        self.logInButton.stopAnimation(animationStyle: .expand, revertAfterDelay: 0 ) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
            
                let newVC2 = TabVC()
            newVC2.modalPresentationStyle = .fullScreen
            self.present(newVC2, animated: true, completion: nil)
                            }
                        }
                    }
        }
    }
    
        @objc func registerBtnPressed() {
    
          let email = emailTF.text ?? ""
          let password = passwordTF.text ?? ""
          if email.isEmpty || password.isEmpty {
                  return
                }
        Auth.auth().createUser(withEmail: email, password: password) { result, error in
         if error != nil {
            print(error as Any)
                return
                  }
        self.signUp.startAnimation()
    DispatchQueue.main.asyncAfter(deadline: .now()+1) {
    self.signUp.stopAnimation(animationStyle: .expand, revertAfterDelay: 0 ) {
        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
                let newVC2 = TabVC()
            newVC2.modalPresentationStyle = .fullScreen
            self.present(newVC2, animated: true, completion: nil)
                            }
                        }
                    }
        }
        }
    
  }

extension LoginVC {
    
  func setupUI() {
      
    view.backgroundColor = .white
    view.addSubview(stackView)
      setupGradientView()
    stackView.addArrangedSubview(segmentedControl)
    stackView.addArrangedSubview(nameTF)
    stackView.addArrangedSubview(emailTF)
    stackView.addArrangedSubview(passwordTF)
    stackView.addArrangedSubview(confTF)
    stackView.addArrangedSubview(logInButton)
    stackView.addArrangedSubview(signUp)
      
    segmentedControl.insertSegment(withTitle: "Rigester", at: 0, animated: true)
    segmentedControl.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
      
    segmentedControl.setTitle("Rigester", forSegmentAt: 0)
    segmentedControl.insertSegment(withTitle: "Login", at: 1, animated: true)
    segmentedControl.setTitle("Login", forSegmentAt: 1)
    segmentedControl.addTarget(self, action: #selector(Segment), for: .valueChanged)
        NSLayoutConstraint.activate([
      stackView.topAnchor.constraint(equalTo: logoImage.topAnchor, constant: 350),
      stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -50),
      stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
      stackView.heightAnchor.constraint(equalToConstant: 270)
    ])
  }
    
    func setupLogoImage() {
        view.addSubview(logoImage)
      logoImage.tintColor = UIColor(ciColor: .black)
      logoImage.layer.masksToBounds = true
      logoImage.layer.cornerRadius = 100
      logoImage.contentMode = .scaleAspectFit
      logoImage.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            logoImage.topAnchor.constraint(equalTo: view.topAnchor,constant: 110),
            logoImage.leftAnchor.constraint(equalTo: view.leftAnchor,constant: 70),
          stackView.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -30),
          stackView.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 30),
            logoImage.heightAnchor.constraint(equalToConstant: 250),
            logoImage.widthAnchor.constraint(equalToConstant: 250),
        ])
    }
    
    
  @objc func Segment(_ sender: Any) {
    switch segmentedControl.selectedSegmentIndex {
    case 0:
      nameTF.isHidden = false
      confTF.isHidden = false
      signUp.isHidden = false
      logInButton.isHidden = true
    case 1:
      nameTF.isHidden = true
      confTF.isHidden = true
      signUp.isHidden = true
      logInButton.isHidden = false
    default:
      break;
    }
  }
    
        private func setupGradientView() {
            setupLogoImage()
            let _ = GradientView(self)
            
        }
}

//class LoginVC: UIViewController, UITextFieldDelegate  {
//
//
//    lazy var logoImage: UIImageView = {
//        let logo = UIImageView()
//        logo.image = UIImage(named: "icon")
//        logo.translatesAutoresizingMaskIntoConstraints = false
////        logo.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
//        logo.layer.cornerRadius = 25
//        logo.isUserInteractionEnabled = true
//
//        return logo
//    }()
//
//    var emailTF: UITextField = {
//        let tf = UITextField()
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.backgroundColor = .systemGray2
//        tf.attributedPlaceholder = NSAttributedString(
//            string: NSLocalizedString("email", comment: ""),
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//        tf.layer.cornerRadius = .minimumMagnitude(20, 20)
//        tf.isSecureTextEntry = false
//
//        return tf
//    }()
//
//    var passwordTF: UITextField = {
//        let tf = UITextField()
//        tf.translatesAutoresizingMaskIntoConstraints = false
//        tf.isSecureTextEntry = true
//        tf.backgroundColor = .systemGray2
//        tf.layer.cornerRadius = .minimumMagnitude(20, 20)
//        tf.attributedPlaceholder = NSAttributedString(
//            string: NSLocalizedString("password", comment: ""),
//            attributes: [NSAttributedString.Key.foregroundColor: UIColor.white])
//
//        return tf
//    }()
//
//    var loginBtn: TransitionButton = {
//        let btn = TransitionButton()
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.layer.cornerRadius = .maximumMagnitude(20, 20)
//        btn.setTitleColor(.black, for: .normal)
//        btn.setTitle(NSLocalizedString("login", comment: ""), for: .normal)
//        btn.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
//        btn.addTarget(self, action: #selector(loginBtnPressed), for: .touchUpInside)
//        return btn
//    }()
//
//    var registerBtn: TransitionButton = {
//        let btn = TransitionButton()
//        btn.setTitleColor(.black, for: .normal)
//        btn.layer.cornerRadius = .maximumMagnitude(20, 20)
//        btn.translatesAutoresizingMaskIntoConstraints = false
//        btn.setTitle(NSLocalizedString("register", comment: ""), for: .normal)
//        btn.backgroundColor = UIColor(red: 216/255, green: 198/255, blue: 174/255, alpha: 1)
//        btn.addTarget(self, action: #selector(registerBtnPressed), for: .touchUpInside)
//        return btn
//    }()
//
//    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
//        emailTF.resignFirstResponder()
//        passwordTF.resignFirstResponder()
//
//               return true
//       }
//
//    override func viewDidLoad() {
//        super.viewDidLoad()
//
//
//        self.emailTF.delegate = self
//        self.passwordTF.delegate = self
//
//        setupGradientView()
//        view.backgroundColor = UIColor(named: "Color")
//
//        view.addSubview(emailTF)
//        view.addSubview(passwordTF)
//        view.addSubview(loginBtn)
//        view.addSubview(registerBtn)
//        view.addSubview(logoImage)
//
//
//        logoImage.tintColor = UIColor(ciColor: .black)
//        logoImage.layer.masksToBounds = true
//        logoImage.layer.cornerRadius = 100
//        logoImage.contentMode = .scaleAspectFit
//        logoImage.translatesAutoresizingMaskIntoConstraints = false
//
//
//        NSLayoutConstraint.activate([
//            logoImage.centerXAnchor.constraint(equalTo: view.centerXAnchor),
//            logoImage.topAnchor.constraint(equalTo: view.topAnchor, constant: 100),
//            logoImage.heightAnchor.constraint(equalToConstant: 300),
//            logoImage.widthAnchor.constraint(equalToConstant: 300)
//        ])
//
//        NSLayoutConstraint.activate([
//            emailTF.topAnchor.constraint(equalTo: view.topAnchor, constant: 440),
//            emailTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
//            emailTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
//            emailTF.heightAnchor.constraint(equalToConstant: 40),
//
//            passwordTF.topAnchor.constraint(equalTo: emailTF.bottomAnchor, constant: 24),
//            passwordTF.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
//            passwordTF.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
//            passwordTF.heightAnchor.constraint(equalToConstant: 40),
//
//            loginBtn.topAnchor.constraint(equalTo: passwordTF.bottomAnchor, constant: 48),
//            loginBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
//            loginBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
//            loginBtn.heightAnchor.constraint(equalToConstant: 40),
//
//
//            registerBtn.topAnchor.constraint(equalTo: loginBtn.bottomAnchor, constant: 24),
//            registerBtn.leftAnchor.constraint(equalTo: view.leftAnchor, constant: 32),
//            registerBtn.rightAnchor.constraint(equalTo: view.rightAnchor, constant: -32),
//            registerBtn.heightAnchor.constraint(equalToConstant: 40),
//        ])
//    }
//
//    private func setupGradientView() {
//        let _ = GradientView(self)
//    }
//
//
//    @objc func registerBtnPressed() {
//
//            let email = emailTF.text ?? ""
//            let password = passwordTF.text ?? ""
//            if email.isEmpty || password.isEmpty {
//              return
//            }
//            Auth.auth().createUser(withEmail: email, password: password) { result, error in
//              if error != nil {
//                print(error as Any)
//                return
//              }
//                self.registerBtn.startAnimation()
//                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//                    self.registerBtn.stopAnimation(animationStyle: .expand, revertAfterDelay: 0 ) {
//                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
//                           let newVC2 = TabVC()
//                            newVC2.navigationItem.largeTitleDisplayMode = .never
//                            self.navigationController?.pushViewController(newVC2,animated: true)
//                        }
//                    }
//                }
//    }
//    }
//
//    @objc func loginBtnPressed() {
//            let email = emailTF.text ?? ""
//            let password = passwordTF.text ?? ""
//            if email.isEmpty || password.isEmpty {
//              return
//            }
//            Auth.auth().signIn(withEmail: email, password: password) { result, error in
//              if error != nil {
//                print(error as Any)
//                return
//              }
//                self.loginBtn.startAnimation()
//                DispatchQueue.main.asyncAfter(deadline: .now()+1) {
//                    self.loginBtn.stopAnimation(animationStyle: .expand, revertAfterDelay: 0 ) {
//                        DispatchQueue.main.asyncAfter(deadline: .now()+0.1) {
//                           let newVC2 = TabVC()
//                            newVC2.navigationItem.largeTitleDisplayMode = .never
//                            self.navigationController?.pushViewController(newVC2,animated: true)
//                        }
//                    }
//                }
//    }
//}
//    }
