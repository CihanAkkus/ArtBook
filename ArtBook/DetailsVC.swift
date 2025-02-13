
import UIKit
import CoreData

class DetailsVC: UIViewController, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    
    let image = UIImageView()
    let nameField = UITextField()
    let artistField = UITextField()
    let yearField = UITextField()
    let saveButton = UIButton()
    
    var chosenPainting = ""
    var chosenPaintingID: UUID?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        image.image = UIImage(named: "selectimage")
        image.frame = CGRect(x: width*0.5 - width*0.8/2,y: height*0.15 , width: width*0.8, height: height*0.3)
        view.addSubview(image)
        
        nameField.placeholder = "Name"
        nameField.textAlignment = .center
        nameField.frame = CGRect(x: 0, y: height*0.45, width: width, height: height*0.10)
        view.addSubview(nameField)
        
        artistField.placeholder = "Artist"
        artistField.textAlignment = .center
        artistField.frame = CGRect(x: 0, y: height*0.55, width: width, height: height*0.10)
        view.addSubview(artistField)
        
        yearField.placeholder = "Year"
        yearField.textAlignment = .center
        yearField.frame = CGRect(x: 0, y: height*0.65, width: width, height: height*0.10)
        view.addSubview(yearField)
        
        saveButton.setTitle("Save",for: UIControl.State.normal)
        saveButton.setTitleColor(UIColor.magenta, for: UIControl.State.normal)
        saveButton.frame = CGRect(x: 0, y: height*0.75, width: width, height: height*0.10)
        view.addSubview(saveButton)
        
        saveButton.addTarget(self, action: #selector(DetailsVC.savePhotoTapped), for: UIControl.Event.touchUpInside)
        
        if chosenPainting != ""{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            
            let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "Paintings")
            
            let idString = chosenPaintingID?.uuidString
            
            fetchRequest.predicate = NSPredicate(format: "id = %@", idString!)
            fetchRequest.returnsObjectsAsFaults = false
            
            do{
                let results = try context.fetch(fetchRequest)
                
                if results.count > 0{
                    
                    for result in results as! [NSManagedObject]{
                        
                        if let name = result.value(forKey: "name") as? String{
                            nameField.text = name
                        }
                        if let artist = result.value(forKey: "artist") as? String{
                            artistField.text = artist
                        }
                        if let year = result.value(forKey: "year") as? Int{
                            yearField.text = String(year)
                        }
                        if let imageData = result.value(forKey: "image") as? Data{
                            let image = UIImage(data: imageData)
                            self.image.image = image
                        }
                        
                        
                    }
                    
                }
                
            }catch{
                print("error")
            }
            
        }
        
        
        //Recognizers
        let gestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(DetailsVC.hideKeyboard))
        view.addGestureRecognizer(gestureRecognizer)
        
        image.isUserInteractionEnabled = true
        let imageTapRecognizer = UITapGestureRecognizer(target: self, action: #selector(selectImage))
        image.addGestureRecognizer(imageTapRecognizer)
        
    }
    
    
    @objc func selectImage(){
        
        let picker = UIImagePickerController()
        picker.delegate = self
        picker.sourceType =  .photoLibrary
        picker.allowsEditing = true
        present(picker, animated: true, completion: nil)

    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        image.image = info[.originalImage] as? UIImage
        self.dismiss(animated: true, completion: nil)
        
    }
    
    
    
    @objc func hideKeyboard(){
        
        view.endEditing(true)
        
    }
    
    @objc func savePhotoTapped(){
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let newPainting = NSEntityDescription.insertNewObject(forEntityName: "Paintings",into: context)
        
        //Attributes
        
        newPainting.setValue(nameField.text!, forKey: "name")
        newPainting.setValue(artistField.text!, forKey: "artist")
        
        if let year = Int(yearField.text!){
            
            newPainting.setValue(year, forKey: "year")
            
        }
        
        newPainting.setValue(UUID(), forKey: "id")

        
        if let imageData = image.image?.jpegData(compressionQuality: 0.5) {
            newPainting.setValue(imageData, forKey: "image")
        }

        
        do{
            try context.save()
            print("success")
        } catch{
            
            print("error")
        }
        
        NotificationCenter.default.post(name: NSNotification.Name("newData"), object: nil)
        self.navigationController?.popViewController(animated: true)
        
        
    }
    

}
