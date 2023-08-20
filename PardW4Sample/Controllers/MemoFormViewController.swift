// Created by byo.

import UIKit

class MemoFormViewController: UIViewController {
    @IBOutlet weak var submitButton: StyledButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var memo: MemoModel?
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        let memo = buildMemoModelFromViews()
        print(memo)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        submitButton.setTitle("Submit", for: .normal)
        applyMemoModel()
    }
    
    private func applyMemoModel() {
        guard let memo = memo else {
            return
        }
        titleTextField.text = memo.title
        contentTextView.text = memo.content
    }
    
    private func buildMemoModelFromViews() -> MemoModel {
        MemoModel(
            title: titleTextField.text ?? "",
            content: contentTextView.text
        )
    }
}
