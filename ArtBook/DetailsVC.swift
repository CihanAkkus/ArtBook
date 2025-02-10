
import UIKit

class DetailsVC: UIViewController {
    
    let image = UIImageView()
    let nameField = UITextField()
    let artistField = UITextField()
    let yearField = UITextField()
    let saveButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let width = view.frame.size.width
        let height = view.frame.size.height
        
        image.frame = CGRect(x: width*0.5 - width*0.8/2,y: height*0.20 , width: width*0.8, height: height*0.4)
        view.addSubview(image)
        
        nameField.placeholder = "Name"
        nameField.textAlignment = .center
        nameField.frame = CGRect(x: 0, y: height*0.65, width: width, height: height*0.15)
        view.addSubview(nameField)
        
        artistField.placeholder = "Artist"
        artistField.textAlignment = .center
        artistField.frame = CGRect(x: 0, y: height*0.80, width: width, height: height*0.15)
        view.addSubview(artistField)
        
        yearField.placeholder = "Year"
        yearField.textAlignment = .center
        yearField.frame = CGRect(x: 0, y: height*0.95, width: width, height: height*0.15)
        view.addSubview(yearField)
        
        saveButton.setTitle("Save",for: UIControl.State.normal)
        saveButton.setTitleColor(UIColor.magenta, for: UIControl.State.normal)
        saveButton.frame = CGRect(x: 0, y: height*1.10, width: width, height: height*0.15)
        view.addSubview(saveButton)
        
        saveButton.addTarget(self, action: #selector(savePhoto), for: UIControl.Event.touchUpInside)
        
    
    }
    
    @objc func savePhoto(){
        
        
        
        
        
    }
    

}
