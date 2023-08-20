// Created by byo.

import UIKit

class MemoListViewController: UIViewController {
    @IBOutlet weak var addButton: StyledButton!
    @IBOutlet weak var memoTableView: UITableView!
    
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
    
    private func buildMemoFormController(memo: MemoModel) -> MemoFormViewController {
        let controller = UIStoryboard(name: "Main", bundle: .main).instantiateViewController(withIdentifier: "MemoForm") as! MemoFormViewController
        controller.memo = memo
        return controller
    }
}
