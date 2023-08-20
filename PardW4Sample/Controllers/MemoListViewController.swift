// Created by byo.

import UIKit

class MemoListViewController: UIViewController {
    @IBOutlet weak var addButton: StyledButton!
    @IBOutlet weak var memoTableView: UITableView!
    
    @IBAction func tapAddButton(_ sender: Any) {
        let controller = buildMemoFormController()
        present(controller, animated: true)
    }
    
    var memos: [MemoModel] = [] {
        didSet {
            memoTableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        addButton.setTitle("Add", for: .normal)
        setupMemoTableView()
    }
    
    private func setupMemoTableView() {
        memoTableView.dataSource = self
        memoTableView.delegate = self
        memoTableView.register(
            UINib(nibName: "TitleContentTableViewCell", bundle: .main),
            forCellReuseIdentifier: "Memo"
        )
    }
    
    fileprivate func buildMemoFormController(memo: MemoModel? = nil) -> MemoFormViewController {
        let controller = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemoForm") as! MemoFormViewController
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
        let cell = tableView.dequeueReusableCell(withIdentifier: "Memo", for: indexPath) as! TitleContentTableViewCell
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
