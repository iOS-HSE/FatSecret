import UIKit

class UserViewController: UIViewController, UITableViewDataSource, UITableViewDelegate, UITextFieldDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return Storage.goals.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell", for: indexPath)
        cell.textLabel?.text = Storage.goals[indexPath.row]
        return cell
    }
    
    
    @IBAction func addGoal(_ sender: Any) {
        showAddDialog()
    }
    @IBOutlet weak var nameField: UITextField!
    @IBOutlet weak var surnameField: UITextField!
    @IBOutlet weak var ageField: UITextField!
    @IBOutlet weak var addressField: UITextField!
    @IBOutlet weak var mailField: UITextField!
    @IBOutlet weak var tableView: UITableView!
    
    private let START_SCREEN_IDENTIFIER: String = "StartScreen"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        nameField.delegate = self
        surnameField.delegate = self
        ageField.delegate = self
        addressField.delegate = self
        mailField.delegate = self
        updateData()
    }
    
    private func showAddDialog() {
        let alert = UIAlertController(title: "New goal", message: "Enter a goal", preferredStyle: .alert)

        alert.addTextField()

        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: { [weak alert] (action) -> Void in
            let textField = alert?.textFields![0]
            guard let goal = textField?.text else { return }
            if goal == "" {
                return
            }
            Storage.goals.append(goal)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func updateData(){
        nameField.text = Storage.name
        surnameField.text = Storage.surname
        ageField.text = String(Storage.age) + " years"
        addressField.text = Storage.address
        mailField.text = Storage.mail
        
    }
    
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        textField.endEditing(true)
        return true
    }
    
    @IBAction func clickExit(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "uid")

        let newViewController = (storyboard?.instantiateViewController(withIdentifier: START_SCREEN_IDENTIFIER ))!
        self.present(newViewController, animated: true, completion: nil)
    }
    
}
