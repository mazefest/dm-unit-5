//
//  EntryDetailViewController.swift
//  Journal-CloudKit
//
//  Created by Colby Mehmen on 7/20/23.
//

import UIKit

protocol EntryDetailViewControllerDelegate {
    func onSave(entry: Entry?, title: String, body: String)
}

class EntryDetailViewController: UIViewController {
    var entry: Entry?
    var delegate: EntryDetailViewControllerDelegate?
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var bodyTextView: UITextView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if entry != nil {
            titleTextField.text = entry?.title
            bodyTextView.text = entry?.body
        }

        // Do any additional setup after loading the view.
    }
    
    @IBAction func onSaveButtonTapped(_ sender: Any) {
        delegate?.onSave(entry: entry, title: titleTextField.text ?? "", body: bodyTextView.text ?? "")
        navigationController?.popViewController(animated: true)
    }
    
    @IBAction func onClearButtonTapped(_ sender: Any) {
        titleTextField.text = ""
        bodyTextView.text = ""
        reloadInputViews()
    }
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
