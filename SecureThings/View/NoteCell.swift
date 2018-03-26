import UIKit

class NoteCell: UITableViewCell {

    @IBOutlet weak var messageLabel: UILabel!
    @IBOutlet weak var lockImageview: UIImageView!
    
    func configure(note: Note) {
        if note.lockStatus == .locked {
            messageLabel.text = "This note is locked. Unlock to read."
            lockImageview.isHidden = false
        } else {
            messageLabel.text = note.message
            lockImageview.isHidden = true
        }
    }

}
