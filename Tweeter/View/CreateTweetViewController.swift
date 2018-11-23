//
//  CreateTweetViewController.swift
//  Tweeter
//
//  Created by mac on 11/22/18.
//  Copyright © 2018 NNM. All rights reserved.
//

import UIKit

protocol CreateTweetDelegate {
    func doCreateTweet(tweet : String)
}

class CreateTweetViewController: UIViewController, UITextViewDelegate {
    var delegate : CreateTweetDelegate?
    
    @IBOutlet weak var createTweetButton: UIBarButtonItem!
    @IBOutlet weak var contentTextView: UITextView!
    
    @IBOutlet weak var textViewBottomConstrain: NSLayoutConstraint!
    
    var editTweek : String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        createTweetButton?.isEnabled = false
        
        NotificationCenter.default.addObserver(
            self,
            selector: #selector(keyboardWillShow),
            name: UIResponder.keyboardWillShowNotification,
            object: nil
        )
        
        contentTextView.becomeFirstResponder()
        
        if (editTweek != nil){
            contentTextView.text = editTweek
        }
    }
    
    @objc func keyboardWillShow(_ notification: Notification) {
        if let keyboardFrame: NSValue = notification.userInfo?[UIResponder.keyboardFrameEndUserInfoKey] as? NSValue {
            let keyboardRectangle = keyboardFrame.cgRectValue
            let keyboardHeight = keyboardRectangle.height
            textViewBottomConstrain.constant = keyboardHeight
        }
    }
    
    @IBAction func cancelPressed(_ sender: Any) {
        self.dismiss(animated: true, completion: nil)
    }
    
    @IBAction func createTweetPressed(_ sender: Any) {
        doTweet()
    }
    
    func doTweet(){
        if let tweetString = contentTextView.text{
            if (TweetViewModel.validTweet(tweetString: tweetString)){
                if let delegate = delegate{
                    dismiss(animated: true, completion: {
                        delegate.doCreateTweet(tweet: tweetString)
                    })
                }
            }else{
                let confirmAlert = UIAlertController.init(title: "Sorry", message: "Your Tweet is not ok!", preferredStyle: .alert)
                let okAction = UIAlertAction.init(title: "Edit", style: .default) { (UIAlertAction) in
                    
                }
                confirmAlert.addAction(okAction)
                present(confirmAlert, animated: true, completion: nil)
            }
        }
    }
    
    func textViewDidChange(_ textView: UITextView) { //Handle the text changes here
        if (textView.text.trimmingCharacters(in: .whitespacesAndNewlines).count == 0){
            createTweetButton?.isEnabled = false
        }else{
            createTweetButton?.isEnabled = true
        }
    }
    
    func textView(_ textView: UITextView, shouldChangeTextIn range: NSRange, replacementText text: String) -> Bool {
        if text == "\n" {
            doTweet()
            return false
        }
        return true
    }
}
