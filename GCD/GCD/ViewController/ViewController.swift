//
//  ViewController.swift
//  GCD
//
//  Created by Raman Kozar on 08/02/2023.
//

import UIKit

class ViewController: UIViewController, UITableViewDataSource, UITableViewDelegate {
       
    @IBOutlet weak var tableView: UITableView!
    
    let cellIdentifier = "FriendCell"
    let heightForRowAt: CGFloat = 50
    let numberOfRowsInSection: Int = 9
    
    var namesArray: [String] = []
    var datesOfMessagesArray: [String] = []
    var imagesArray: [String] = []
    var messagesArray: [String] = []
    
    let parsingGroup = DispatchGroup()
    
    let spinnerView = SpinnerViewController()
    
    let storeQueue = DispatchQueue.global(qos: .userInteractive)
    let parsingQueue = DispatchQueue.init(label: "parsing", attributes: .concurrent)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        checkStore()
        moveIndicator()
        
    }
    
    func checkStore() {
        
        storeQueue.async {
            if let path = Bundle.main.path(forResource: "UsersData", ofType: "plist") {
                let dict = NSDictionary(contentsOfFile: path) as! [String: Any]
                self.appendDateFromPlistFileConcurrent(dict)
            }
        }
        print("1...\(self.imagesArray.count)")
        
    }
    
    private func appendDateFromPlistFileConcurrent(_ dict: [String: Any]) {
        
        parsingGroup.enter()
        parsingQueue.async {
            sleep(3)
            self.namesArray = dict["allNames"] as! Array<String>
            self.parsingGroup.leave()
        }
        
        parsingGroup.enter()
        parsingQueue.async {
            sleep(3)
            self.datesOfMessagesArray = dict["allDates"] as! Array<String>
            self.parsingGroup.leave()
        }
        
        parsingGroup.enter()
        parsingQueue.async {
            sleep(3)
            self.imagesArray = dict["allImages"] as! Array<String>
            self.parsingGroup.leave()
        }
        
        parsingGroup.enter()
        parsingQueue.async {
            sleep(3)
            self.messagesArray = dict["allMessages"] as! Array<String>
            self.parsingGroup.leave()
        }
        
    }
    
    func stopIndicator() {
        
        self.spinnerView.willMove(toParent: nil)
        self.spinnerView.view.removeFromSuperview()
        self.spinnerView.removeFromParent()
        
    }
    
    func moveIndicator() {
        
        addChild(spinnerView)
        spinnerView.view.frame = view.frame
        view.addSubview(spinnerView.view)
        spinnerView.didMove(toParent: self)
        
    }
    
    private func clearRow(_ currentCell: FriendCell) {
        
        currentCell.userName.text = ""
        currentCell.userDateOfMessage.text = ""
        currentCell.userMessage.text = ""
        currentCell.userImage.image = UIImage()
        
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return heightForRowAt
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        guard let currentCell = tableView.dequeueReusableCell(withIdentifier: cellIdentifier, for: indexPath) as? FriendCell else {
            return UITableViewCell()
        }
        
        clearRow(currentCell)
        
        parsingGroup.notify(queue: .main) {
            
            currentCell.userName.text = self.namesArray[indexPath.row]
            currentCell.userImage.image = UIImage(named: self.imagesArray[indexPath.row])
            currentCell.userDateOfMessage.text = self.datesOfMessagesArray[indexPath.row]
            currentCell.userMessage.text = self.messagesArray[indexPath.row]
            
            self.stopIndicator()
            
        }
        
        return currentCell
        
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return numberOfRowsInSection
    }

}

