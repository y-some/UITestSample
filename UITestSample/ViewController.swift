//
//  ViewController.swift
//  UITestSample
//
//  Created by Yasuyuki Someya on 2018/12/15.
//  Copyright © 2018年 Yasuyuki Someya. All rights reserved.
//

import UIKit

class ViewController: UIViewController {

    // MARK: - UI Parts
    
    let textView: UITextView = {
        let textView = UITextView()
        textView.translatesAutoresizingMaskIntoConstraints = false
        textView.text =
            """
            Hello world!

            XCUITestのサンプルです。
            """
        textView.font = UIFont.boldSystemFont(ofSize: 22)
        textView.textAlignment = .center
        textView.isEditable = false
        textView.isScrollEnabled = false
        textView.accessibilityIdentifier = "ViewController_textView"
        return textView
    }()
    
    let button: UIButton = {
        let button = UIButton(type: UIButton.ButtonType.system)
        button.translatesAutoresizingMaskIntoConstraints = false
        button.setTitle("Tap me", for: .normal)
        button.titleLabel?.font = UIFont.systemFont(ofSize: 18)
        button.accessibilityIdentifier = "ViewController_button"
        return button
    }()
    
    let label: UILabel = {
        let label = UILabel()
        label.translatesAutoresizingMaskIntoConstraints = false
        label.font = UIFont.systemFont(ofSize: 18)
        label.textColor = .gray
        label.text = ""
        label.accessibilityIdentifier = "ViewController_label"
        return label
    }()
    
    // MARK: - UIViewController LifeCycle

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(textView)
        view.addSubview(button)
        button.addTarget(self, action: #selector(tappedButton), for: .touchUpInside)
        view.addSubview(label)
        setupLayout()
    }

    private func setupLayout() {
        NSLayoutConstraint.activate([
            textView.topAnchor.constraint(equalTo: view.topAnchor, constant: 120),
            textView.leftAnchor.constraint(equalTo: view.leftAnchor),
            textView.rightAnchor.constraint(equalTo: view.rightAnchor),
            textView.heightAnchor.constraint(equalToConstant: 100)
            ])
        NSLayoutConstraint.activate([
            button.topAnchor.constraint(equalTo: textView.bottomAnchor, constant: 40),
            button.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        button.sizeToFit()
        NSLayoutConstraint.activate([
            label.topAnchor.constraint(equalTo: button.bottomAnchor, constant: 40),
            label.centerXAnchor.constraint(equalTo: view.centerXAnchor)
            ])
        label.sizeToFit()
    }
}

// MARK: - Actions

extension ViewController {
    @objc func tappedButton(_ sender: Any?) {
        let actionSheet = UIAlertController(title: "タイトル", message: "メッセージ", preferredStyle: .actionSheet)
        
        let action1 = UIAlertAction(title: "Action1", style: .default, handler: {
            (action: UIAlertAction!) in
            self.label.text = "Action1がtapされました"
        })
        
        let action2 = UIAlertAction(title: "Action2", style: .default, handler: {
            (action: UIAlertAction!) in
            self.label.text = "Action2がtapされました"
        })
        
        let cancel = UIAlertAction(title: "Cancel", style: .cancel, handler: {
            (action: UIAlertAction!) in
            self.label.text = ""
        })
        
        actionSheet.addAction(action1)
        actionSheet.addAction(action2)
        actionSheet.addAction(cancel)
        
        self.present(actionSheet, animated: true, completion: nil)
    }
}
