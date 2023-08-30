// Created by byo.

import UIKit

class MemoFormViewController: UIViewController {
    var memo: MemoModel?
    weak var delegate: MemoFormViewControllerDelegate?
    
    private lazy var submitButton: StyledButton = {
        let action = UIAction { [weak self] _ in
            self?.submitMemoAndDismiss()
        }
        let button = StyledButton(primaryAction: action)
        button.setTitle("Submit", for: .normal)
        return button
    }()
    
    private lazy var titleTextField: UITextField = {
        let textField = UITextField()
        textField.placeholder = "Title"
        textField.font = .preferredFont(forTextStyle: .largeTitle)
        return textField
    }()
    
    private lazy var contentTextView: UITextView = {
        let textView = UITextView()
        textView.font = .preferredFont(forTextStyle: .body)
        return textView
    }()
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        applyMemoModelIfExists()
    }
    
    private func setupViews() {
        setupView()
        [submitButton, titleTextField, contentTextView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupView() {
        let padding: CGFloat = 16
        view.backgroundColor = .white
        view.layoutMargins = .init(top: padding, left: padding, bottom: padding, right: padding)
    }
    
    private func setupConstraints() {
        let layoutGuide = view.layoutMarginsGuide
        let spacing: CGFloat = 8
        NSLayoutConstraint.activate([
            submitButton.topAnchor.constraint(equalTo: layoutGuide.topAnchor),
            submitButton.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            
            titleTextField.topAnchor.constraint(equalTo: submitButton.bottomAnchor, constant: spacing),
            titleTextField.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            titleTextField.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor),
            
            contentTextView.topAnchor.constraint(equalTo: titleTextField.bottomAnchor, constant: spacing),
            contentTextView.bottomAnchor.constraint(equalTo: layoutGuide.bottomAnchor),
            contentTextView.leadingAnchor.constraint(equalTo: layoutGuide.leadingAnchor),
            contentTextView.trailingAnchor.constraint(equalTo: layoutGuide.trailingAnchor)
        ])
    }
    
    private func applyMemoModelIfExists() {
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
