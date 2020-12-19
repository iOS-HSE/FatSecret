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
    @IBAction func clickEdit(_ sender: Any) {
        handleEdit()
    }
    @IBAction func clickSave(_ sender: Any) {
        handleSave()
    }
    @IBOutlet weak var editButton: UIButton!
    @IBOutlet weak var saveButton: UIButton!
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
        changeTextFields(isEditingEnabled: false)
    }
    
    private func handleEdit() {
        changeTextFields(isEditingEnabled: true)
    }
    
    private func handleSave() {
        changeTextFields(isEditingEnabled: false)
        Storage.updateUserInfo(
            name: nameField.text ?? "",
            surname: surnameField.text ?? "",
            age: calculateAge(ageField.text ?? ""),
            address: addressField.text ?? "",
            mail: mailField.text ?? ""
        )
    }
    
    private func calculateAge(_ ageText: String) -> Int {
        if ageText == "" {
            return 0
        }
        return Int(ageText) ?? 0
    }
    
    private func changeTextFields(isEditingEnabled: Bool) {
        nameField.isUserInteractionEnabled = isEditingEnabled
        surnameField.isUserInteractionEnabled = isEditingEnabled
        ageField.isUserInteractionEnabled = isEditingEnabled
        addressField.isUserInteractionEnabled = isEditingEnabled
        mailField.isUserInteractionEnabled = isEditingEnabled
        editButton.isEnabled = !isEditingEnabled
        saveButton.isEnabled = isEditingEnabled
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
            Storage.addGoal(goal)
            self.tableView.reloadData()
        }))
        
        alert.addAction(UIAlertAction(title: "Cancel", style: .default, handler: nil))

        self.present(alert, animated: true, completion: nil)
    }
    
    func updateData(){
        nameField.text = Storage.name
        surnameField.text = Storage.surname
        ageField.text = String(Storage.age)
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
