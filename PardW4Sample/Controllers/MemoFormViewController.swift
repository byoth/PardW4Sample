// Created by byo.

import UIKit

class MemoFormViewController: UIViewController {
    @IBOutlet weak var submitButton: StyledButton!
    @IBOutlet weak var titleTextField: UITextField!
    @IBOutlet weak var contentTextView: UITextView!
    
    var memo: MemoModel?
    weak var delegate: MemoFormViewControllerDelegate?
    
    @IBAction func tapSubmitButton(_ sender: Any) {
        submitMemoAndDismiss()
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
    
    private func submitMemoAndDismiss() {
        let memo = buildMemoModelFromViews()
        delegate?.memoFormDidSubmit(memo)
        dismiss(animated: true)
    }
    
    private func buildMemoModelFromViews() -> MemoModel {
        MemoModel(
            uuid: memo?.uuid ?? UUID(),
            title: titleTextField.text ?? "",
            content: contentTextView.text
        )
    }
}
