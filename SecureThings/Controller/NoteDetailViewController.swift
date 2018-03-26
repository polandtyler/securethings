import UIKit

class NoteDetailViewController: UIViewController, UITextFieldDelegate {
    var note: Note!
    var index: Int!

    @IBOutlet weak var messageTextView: UITextView!
    @IBOutlet weak var lockNoteButton: UIButton!

    override func viewDidLoad() {
        super.viewDidLoad()
        
        let lockTitle = note.lockStatus == .locked ? "UNLOCK" : "LOCK NOTE"
        let messageTitle = note.lockStatus == .locked ? "This note is locked. Click unlock button below to read." : note.message
        lockNoteButton.setTitle(lockTitle, for: .normal)
        messageTextView.text = messageTitle
    }
    
    
    @IBAction func didPressLockNoteButton(_ sender: Any) {
        if note.lockStatus == .unlocked {
            notesArray[index].lockStatus = lockStatusFlipper(lockStatus: note.lockStatus)
            navigationController?.popViewController(animated: true)
        } else {
            // do touchID stuff
        }
    }
}
