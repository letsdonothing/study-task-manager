//
//  ViewController.swift
//  study notes
//
//  Created by Sergius on 09.09.2018.
//  Copyright © 2018 Sergius. All rights reserved.
//

import UIKit

class ViewController: UIViewController, UITextViewDelegate {
    var button = DropDownBtn()
    let db = DBService.shared
    
    @IBOutlet weak var taskDescription: UITextView!
    @IBOutlet weak var datePicker: UIDatePicker!
    @IBOutlet weak var addTaskButton: UIButton!
    
    var buttonWidth: CGFloat {
        return UIScreen.main.bounds.width - 32
    }
    var buttonPositionFromCenter: CGFloat {
        return 120 - UIScreen.main.bounds.height / 2
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Configure the button
        button = DropDownBtn.init(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
        button.setTitle("Select the subject..", for: .normal)
        button.setTitleColor(UIColor.lightGray, for: .normal)
        button.layer.borderWidth = 1.0
        button.layer.borderColor = UIColor.lightGray.cgColor
        button.translatesAutoresizingMaskIntoConstraints = false
        
        self.view.addSubview(button)
                
        //Button Constraints
        button.centerXAnchor.constraint(equalTo: self.view.centerXAnchor).isActive = true
        button.centerYAnchor.constraint(equalTo: self.view.centerYAnchor, constant: buttonPositionFromCenter).isActive = true
        button.widthAnchor.constraint(equalToConstant: buttonWidth).isActive = true
        button.heightAnchor.constraint(equalToConstant: 50).isActive = true
        
        //Set the drop down menu's options
        button.dropView.dropDownOptions = ["Math", "English", "Russian", "IT Systems", "Algorithms", "Multimedia technologies"]
        
        taskDescription.layer.borderColor = UIColor.lightGray.cgColor
        taskDescription.layer.borderWidth = 1.0
        taskDescription.layer.cornerRadius = 10.0
        taskDescription.textContainerInset = UIEdgeInsets(top: 15, left: 10, bottom: 15, right: 10)
        
        //Placeholder:
        taskDescription.text = "Enter description of the task.."
        taskDescription.textColor = UIColor.lightGray
        taskDescription.delegate = self
        
        
        datePicker.minuteInterval = 10
        // For 24 Hrs
        datePicker.locale = Locale(identifier: "en_GB")
        
        addTaskButton.layer.cornerRadius = 10.0
    }
    
    func textViewDidBeginEditing(_ textView: UITextView) {
        if taskDescription.text == "Enter description of the task.." {
            taskDescription.text = ""
            taskDescription.textColor = UIColor.black
        }
    }
    
    func textViewDidEndEditing(_ textView: UITextView) {
        if taskDescription.text.isEmpty {
            taskDescription.text = "Enter description of the task.."
            taskDescription.textColor = UIColor.lightGray
        }
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func addTaskAction(_ sender: Any) {
        taskDescription.endEditing(true)
        
        if (taskDescription.text.isEmpty || taskDescription.text == "Enter description of the task..") {
            taskDescription.textColor = UIColor.red
            if button.titleLabel?.text == "Select the subject.." {
                button.titleLabel?.textColor = UIColor.red
            }
            return
        }
        
        if button.titleLabel?.text == "Select the subject.." {
            button.titleLabel?.textColor = UIColor.red
            return
        }
        
        db.setTask(description: taskDescription.text, subject: (button.titleLabel?.text)!, till: datePicker.date)

        self.navigationController?.popViewController(animated: true)
    }
    
    
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}
