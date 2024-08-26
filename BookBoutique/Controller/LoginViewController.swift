//
//  LoginViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 7.08.2024.
//

import UIKit
import CoreData

class LoginViewController: UIViewController {

    @IBOutlet weak var MailTextField: UITextField!
    @IBOutlet weak var PasswordTextField: UITextField!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    }

    @IBAction func LoginButton(_ sender: Any) {
        authenticateUser()
    }
    @IBAction func SignInButton(_ sender: Any) {
        performSegue(withIdentifier: "toUyeOl", sender: nil)
    }
    
    func authenticateUser() {
           guard let appDelegate = UIApplication.shared.delegate as? AppDelegate else { return }
           let Context = appDelegate.persistentContainer.viewContext

           let fetchRequest = NSFetchRequest<NSManagedObject>(entityName: "User")
           fetchRequest.predicate = NSPredicate(format: "email == %@ AND password == %@", MailTextField.text!, PasswordTextField.text!)

           do {
               let users = try Context.fetch(fetchRequest)
               if users.count > 0 {
                   performSegue(withIdentifier: "toCategoryy", sender: nil)
               } else {
                   showAlert(message: "E-posta veya şifre yanlış.")
               }
           } catch let error as NSError {
               print("Hata!. \(error), \(error.userInfo)")
           }
       }
    func showAlert(message: String) {
            let alert = UIAlertController(title: "Hata", message: message, preferredStyle: .alert)
            alert.addAction(UIAlertAction(title: "Tamam", style: .default, handler: nil))
            self.present(alert, animated: true, completion: nil)
        }
}
