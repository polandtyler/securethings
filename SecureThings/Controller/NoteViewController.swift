import UIKit
import LocalAuthentication

class NoteViewController: UIViewController {

    @IBOutlet weak var tableView: UITableView!

    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        
        setupLockAll()
    }
    
    private func setupLockAll() {
        let item = UIBarButtonItem(title: "Lock All", style: .plain, target: self, action: #selector(lockAllNotes))
        navigationItem.setLeftBarButton(item, animated: true)
    }
    
    @objc func lockAllNotes() {
        for note in notesArray {
            if note.lockStatus == .unlocked {
                note.lockStatus = lockStatusFlipper(lockStatus: note.lockStatus)
                self.tableView.reloadData()
            }
        }
    }

    @IBAction func didSelectAddButton(_ sender: Any) {
        guard let addNoteController = storyboard?.instantiateViewController(withIdentifier: "AddNoteViewController") as? AddNoteViewController else { return }
        navigationController?.pushViewController(addNoteController, animated: true)
    }
    
    func authenticateBiometrics(completion: @escaping (Bool) -> Void) {
        let context = LAContext()
        let localizedReasonString = "Our app uses TouchID/FaceID to secure your notes."
        var authError: NSError?
        
        if #available(iOS 8.0, macOS 10.12.1, *) {
            if context.canEvaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, error: &authError) {
                context.evaluatePolicy(.deviceOwnerAuthenticationWithBiometrics, localizedReason: localizedReasonString, reply: { (success, evaluateError) in
                    if success {
                        completion(true)
                    } else {
                        guard let evaluateErrorString = evaluateError?.localizedDescription else { return }
                        
                        self.showAlert(withMessage: evaluateErrorString)
                        completion(false)
                    }
                })
            } else {
                guard let authErrorString = authError?.localizedDescription else { return }
                
                self.showAlert(withMessage: authErrorString)
                completion(false)
            }
        } else {
            completion(false)
        }
    }
    
    func showAlert(withMessage message: String) {
        let alertVC = UIAlertController(title: "Error", message: message, preferredStyle: .alert)
        let action = UIAlertAction(title: "OK", style: .default, handler: nil)
        
        alertVC.addAction(action)
        present(alertVC, animated: true, completion: nil)
    }
    
}

extension NoteViewController: UITableViewDelegate, UITableViewDataSource {

    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return notesArray.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tableView.dequeueReusableCell(withIdentifier: "noteCell", for: indexPath) as? NoteCell else { return UITableViewCell() }
        cell.configure(note: notesArray[indexPath.row])
        return cell
    }

    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if notesArray[indexPath.row].lockStatus == .locked {
            authenticateBiometrics(completion: { (authenticated) in
                if authenticated {
                    notesArray[indexPath.row].lockStatus = lockStatusFlipper(lockStatus: notesArray[indexPath.row].lockStatus)
                    
                    // put back on main thread since touchID and faceID happen on background thread
                    DispatchQueue.main.async {
                        self.pushNote(for: indexPath)
                    }
                }
            })
        } else {
            pushNote(for: indexPath)
        }
    }
    
    private func pushNote(for indexPath: IndexPath) {
        guard let noteDetailViewController = storyboard?.instantiateViewController(withIdentifier: "NoteDetailVC") as? NoteDetailViewController else { return }
        noteDetailViewController.note = notesArray[indexPath.row]
        noteDetailViewController.index = indexPath.row
        navigationController?.pushViewController(noteDetailViewController, animated: true)
    }
}
