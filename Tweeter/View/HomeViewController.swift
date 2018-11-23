//
//  ViewController.swift
//  Tweeter
//
//  Created by mac on 11/22/18.
//  Copyright © 2018 NNM. All rights reserved.
//

import UIKit

class HomeViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, CreateTweetDelegate {
    
    var tweetViewModel = TweetViewModel()

    @IBOutlet weak var newTweetButton: UIButton!
    @IBOutlet weak var tweetTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tweetTableView.tableFooterView = UIView()
        updateUI()
    }

    @IBAction func newTweekPressed(_ sender: Any) {
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let createPostVC = sb.instantiateViewController(withIdentifier: "create_tweet_vc") as! CreateTweetViewController
        createPostVC.delegate = self
        present(createPostVC, animated: true, completion: nil)
    }
    
    func doCreateTweet(tweet: String) {
        if (tweetViewModel.addTweet(tweetString: tweet)){
            tweetTableView.reloadData()
            updateUI()
        }else{
            let confirmAlert = UIAlertController.init(title: "Sorry", message: "Your Tweet is not ok!", preferredStyle: .alert)
            let okAction = UIAlertAction.init(title: "Edit", style: .default) { (UIAlertAction) in
                self.editTweet(tweetString: tweet)
            }
            let cancelAction = UIAlertAction.init(title: "Cancel", style: .cancel) { (UIAlertAction) in
                
            }
            confirmAlert.addAction(okAction)
            confirmAlert.addAction(cancelAction)
            self.present(confirmAlert, animated: true, completion: nil)
        }
    }
    
    func editTweet(tweetString : String){
        let sb = UIStoryboard.init(name: "Main", bundle: Bundle.main)
        let createPostVC = sb.instantiateViewController(withIdentifier: "create_tweet_vc") as! CreateTweetViewController
        createPostVC.delegate = self
        createPostVC.editTweek = tweetString
        present(createPostVC, animated: true, completion: nil)
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")!
        cell.textLabel?.text = tweetViewModel.getTweetAtIndex(index: indexPath.row)
        cell.textLabel?.numberOfLines = 0
        
        return cell
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return tweetViewModel.count()
    }
    
    func updateUI(){
        if (tweetViewModel.count() != 0){
            tweetTableView.isHidden = false
        }else{
            tweetTableView.isHidden = true
            newTweetButton.transform = CGAffineTransform(scaleX: 0.1, y: 0.1)
            
            UIView.animate(withDuration: 2.0, delay: 0, usingSpringWithDamping: 0.1, initialSpringVelocity: 3.0, options: .allowUserInteraction, animations: {
                [weak self] in self?.newTweetButton.transform = .identity
            }, completion: nil)
        }
    }
}

