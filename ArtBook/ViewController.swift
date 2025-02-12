

import UIKit
import CoreData

class ViewController: UIViewController,UITableViewDelegate,UITableViewDataSource {
    
    let tableView = UITableView()
    
    var nameArray = [String]()
    var idArray = [UUID]()

    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.navigationBar.topItem?.rightBarButtonItem = UIBarButtonItem(barButtonSystemItem:UIBarButtonItem.SystemItem.add, target: self, action: #selector (addButtonTapped))
        
        tableView.frame = view.bounds
        tableView.delegate = self
        tableView.dataSource = self
        
        view.addSubview(tableView)
        
        getData()
        
        
    }
    
    
    func getData(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
        fetchRequest.returnsObjectsAsFaults = false
        
        do{
            let results = try context.fetch(fetchRequest)
            
            for result in results as! [NSManagedObject]{
                if let name = result.value(forKey: "name") as? String{
                    self.nameArray.append(name)
                }
                if let id = result.value(forKey: "id") as? UUID{
                    self.idArray.append(id)
                }
                self.tableView.reloadData()

                
            }
        }catch {
            print("error")
        }
        

        
        
    }
    
    
    
    
    
    @objc func addButtonTapped(){
        
        performSegue(withIdentifier: "toDetailsVC", sender: nil)
    
    }
    
    
    
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return self.nameArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = UITableViewCell()
        var content = cell.defaultContentConfiguration()
        content.text = self.nameArray[indexPath.row]
        cell.contentConfiguration = content
        return cell
        
    }
    
    


}

