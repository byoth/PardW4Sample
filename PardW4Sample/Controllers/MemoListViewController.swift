// Created by byo.

import UIKit

class MemoListViewController: UIViewController {
    var memos: [MemoModel] = [] {
        didSet {
            memoTableView.reloadData()
        }
    }
    
    private let cellIdentifier = "Memo"
    
    private lazy var addButton: StyledButton = {
        let action = UIAction { [weak self] _ in
            self?.presentMemoFormController()
        }
        let button = StyledButton(primaryAction: action)
        button.setTitle("Add", for: .normal)
        return button
    }()
    
    private lazy var memoTableView: UITableView = {
        let tableView = UITableView()
        tableView.dataSource = self
        tableView.delegate = self
        tableView.register(TitleContentTableViewCell.self, forCellReuseIdentifier: cellIdentifier)
        return tableView
    }()
    
    override func loadView() {
        super.loadView()
        setupViews()
    }
    
    private func setupViews() {
        view.backgroundColor = .white
        [addButton, memoTableView].forEach {
            $0.translatesAutoresizingMaskIntoConstraints = false
            view.addSubview($0)
        }
        setupConstraints()
    }
    
    private func setupConstraints() {
        let safeAreaGuide = view.safeAreaLayoutGuide
        NSLayoutConstraint.activate([
            addButton.topAnchor.constraint(equalTo: safeAreaGuide.topAnchor, constant: 8),
            addButton.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor, constant: -8),
            
            memoTableView.topAnchor.constraint(equalTo: addButton.bottomAnchor, constant: 16),
            memoTableView.bottomAnchor.constraint(equalTo: safeAreaGuide.bottomAnchor),
            memoTableView.leadingAnchor.constraint(equalTo: safeAreaGuide.leadingAnchor),
            memoTableView.trailingAnchor.constraint(equalTo: safeAreaGuide.trailingAnchor)
        ])
    }
    
    private func presentMemoFormController() {
        let controller = buildMemoFormController()
        present(controller, animated: true)
    }
    
    fileprivate func buildMemoFormController(memo: MemoModel? = nil) -> MemoFormViewController {
        let controller = MemoFormViewController()
        controller.memo = memo
        controller.delegate = self
        return controller
    }
}

extension MemoListViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        memos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as! TitleContentTableViewCell
        let memo = memos[indexPath.item]
        cell.titleLabel.text = memo.title
        cell.contentLabel.text = memo.content
        return cell
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        60
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let memo = memos[indexPath.item]
        let controller = buildMemoFormController(memo: memo)
        present(controller, animated: true)
    }
}

extension MemoListViewController: MemoFormViewControllerDelegate {
    func memoFormDidSubmit(_ memo: MemoModel) {
        if let existingIndex = memos.firstIndex(where: { $0.uuid == memo.uuid }) {
            memos[existingIndex] = memo
        } else {
            memos.append(memo)
        }
    }
}
