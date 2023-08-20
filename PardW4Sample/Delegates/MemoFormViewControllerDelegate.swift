// Created by byo.

import Foundation

protocol MemoFormViewControllerDelegate: AnyObject {
    func memoFormDidSubmit(_ memo: MemoModel)
}
