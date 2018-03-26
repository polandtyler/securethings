import UIKit

class AddNoteViewController: UIViewController {

    @IBOutlet weak var textField: UITextView!
    @IBOutlet weak var lockedToggle: UISwitch!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        textField.becomeFirstResponder()
        
        
        let buttonItem = UIBarButtonItem(barButtonSystemItem: .done, target: nil, action: #selector(doneSelected))
        buttonItem.tintColor = UIColor.orange
        navigationItem.setRightBarButton(buttonItem, animated: true)
    }
    
    
    @IBAction func didPressAddNoteButton(_ sender: Any) {
        let note = Note(message: textField.text, lockStatus: lockedToggle.isOn ? .locked : .unlocked)
        // seems really bad to be using this global array. refactor to use coredata, firebase, or really anything?
        notesArray.append(note)
        navigationController?.popViewController(animated: true)
    }
    
    
    
    @objc func doneSelected() {
        view.endEditing(true)
    }
    
}
