//
//  CategoryViewController.swift
//  BookBoutique
//
//  Created by Esna nur Yılmaz on 7.08.2024.
//

import UIKit

class CategoryViewController: UIViewController {

    @IBOutlet weak var CategoryTableView: UITableView!
    var categoryList = [Category]()
    
    override func viewDidLoad() {
        super.viewDidLoad()

       CategoryTableView.dataSource = self
        CategoryTableView.delegate = self
        getcategories()
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        let indeks = sender as? Int
        let VC = segue.destination as! BooksViewController
        VC.categories = categoryList[indeks!]
    }
    func getcategories(){
        let url = URL(string: "http://localhost:8080/category/findAll")!
        URLSession.shared.dataTask(with: url) { data , response , error in
            if error != nil || data == nil {
                print("Error")
                return
            }
            do{
                let response = try JSONDecoder().decode(CategoryResponse.self, from: data!)
                if let getCategoryList = response.category {
                    self.categoryList = getCategoryList
                }
                DispatchQueue.main.async {
                    self.CategoryTableView.reloadData()
                }
            }catch{
                print(error.localizedDescription)
            }
        }.resume()
    }
}
extension CategoryViewController : UITableViewDelegate , UITableViewDataSource {
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return categoryList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let category = categoryList[indexPath.row]
        let cell = tableView.dequeueReusableCell(withIdentifier: "categoryHucre", for: indexPath) as! CategoryTableViewCell
        cell.CategoryLabel.text = category.categoryName
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        performSegue(withIdentifier: "toBooks", sender: indexPath.row)
    }
    
}

