//
//  SignInViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 8.08.2024.
//

import UIKit
import CoreData

class SignInViewController: UIViewController {
    
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var surnameTextField: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    @IBOutlet weak var EmailTextField: UITextField!
   
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    @IBAction func signInButton(_ sender: Any) {
        saveUser()
        performSegue(withIdentifier: "toHomePage", sender: nil)
        
    }
    @IBAction func loginButton(_ sender: Any) {
        performSegue(withIdentifier: "toLoginn", sender: nil)
    }
    func saveUser() {
        guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return
        }
            let Context = appDelegate.persistentContainer.viewContext
            let Entity = NSEntityDescription.entity(forEntityName: "User", in: Context)!
            let user = NSManagedObject(entity: Entity, insertInto: Context)
        
                user.setValue(nameTextField.text, forKeyPath: "firstName")
                user.setValue(surnameTextField.text, forKeyPath: "lastName")
                user.setValue(passwordTextField.text, forKeyPath: "password")
                user.setValue(EmailTextField.text, forKeyPath: "email")

                do {
                    try Context.save()
                } catch let error as NSError {
                    print("Üye Olunamadı!. \(error), \(error.userInfo)")
                }
    }
    
}
