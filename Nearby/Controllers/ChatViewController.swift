//
//  ChatViewController.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 09/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation
import UIKit
/*
import SCSDKLoginKit
import SCSDKBitmojiKit
*/

//fileprivate let externalIdQuery = "{me{externalId}}"

struct Constants {
    static let AccessoryViewHeight: CGFloat = 48.0
}

class ChatViewController: UICollectionViewController, UICollectionViewDelegateFlowLayout {
    
    private let cellId = "cellId"
    
    var room: Room? {
        didSet {
            navigationItem.title = room?.name
        }
    }
    
    /*
    var externalId: String? {
        didSet {
            navigationItem.rightBarButtonItems = externalId == nil ? [unlinkButton] : [unlinkButton, friendmojiButton]
        }
    }
     */
    
    //let bottomSheetController = BottomSheetViewController()
    
    let inputBar = UIVisualEffectView(effect: UIBlurEffect(style: .light))
    
    lazy var sendButton: UIButton = {
        let button = UIButton(type: .custom)
        button.setImage(UIImage(named: "send_inactive"), for: .disabled)
        button.setImage(UIImage(named: "send_active"), for: .normal)
        button.isEnabled = false
        button.addTarget(self, action: #selector(handleSend), for: .touchUpInside)
        button.sizeToFit()
        return button
    }()
    
    lazy var inputTextField: UITextField = {
        let textField = UITextField()
        textField.backgroundColor = UIColor.white
        textField.layer.borderColor = UIColor.lightGray.cgColor
        textField.layer.borderWidth = 0.5
        textField.layer.cornerRadius = 18
        textField.placeholder = "Express yourself..."
        textField.leftView = UIView(frame: CGRect(x: 0, y: 0, width: 14, height: 0))
        textField.rightView = sendButton
        textField.leftViewMode = .always
        textField.rightViewMode = .always
        textField.translatesAutoresizingMaskIntoConstraints = false
        textField.delegate = self
        textField.addTarget(self, action: #selector(textChanged), for: .editingChanged)
        return textField
    }()
    
    @objc func textChanged() {
        sendButton.isEnabled = !(inputTextField.text?.isEmpty ?? true)
    }
    
    let topBorderView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor(white: 0.4, alpha: 0.5)
        return view
    }()
    
    /*
    let stickerVC = SCSDKBitmojiStickerPickerViewController()
    
    lazy var bitmojiButton: SCSDKBitmojiIconView = {
        let button = SCSDKBitmojiIconView()
        button.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(toggleStickerViewVisible)))
        return button
    }()
    */
    
    lazy var inputContainerView: UIView = {
        let view = UIView()
        view.backgroundColor = UIColor.white
        view.frame = CGRect.init(x: 0, y: 0, width: self.view.frame.width, height: Constants.AccessoryViewHeight)
        
        // put border radius to the bottom
        //view.clipsToBounds = true
        //view.layer.cornerRadius = 5
        //view.layer.maskedCorners = [.layerMaxXMaxYCorner, .layerMinXMaxYCorner]
        
        inputBar.translatesAutoresizingMaskIntoConstraints = false
        view.addSubview(inputBar)
        
        //bitmojiButton.translatesAutoresizingMaskIntoConstraints = false
        //view.addSubview(self.bitmojiButton)

        view.addSubview(self.inputTextField)
        
        view.addSubview(self.topBorderView)
        
        NSLayoutConstraint.activate([
            inputBar.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            inputBar.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            inputBar.heightAnchor.constraint(equalToConstant: Constants.AccessoryViewHeight),
            /*
            bitmojiButton.centerYAnchor.constraint(equalTo: inputBar.centerYAnchor),
            bitmojiButton.heightAnchor.constraint(equalTo: inputTextField.heightAnchor),
            bitmojiButton.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 5),
            bitmojiButton.widthAnchor.constraint(equalTo: inputTextField.heightAnchor),
            */
            inputTextField.centerYAnchor.constraint(equalTo: inputBar.centerYAnchor),
            inputTextField.heightAnchor.constraint(equalToConstant: 36),
            //inputTextField.leadingAnchor.constraint(equalTo: bitmojiButton.trailingAnchor, constant: 10),
            inputTextField.leadingAnchor.constraint(equalTo: view.leadingAnchor, constant: 10),
            inputTextField.trailingAnchor.constraint(equalTo: view.trailingAnchor, constant: -10),
        ])
        
        return view
    }()
    
    override var canBecomeFirstResponder: Bool {
        return true
    }
    
    override var inputAccessoryView: UIView? {
        get {
            return inputContainerView
        }
    }
    
    @objc private func handleSend() {
        guard let text = inputTextField.text, !text.isEmpty else {
            return
        }
        
        SocketService.instance.sendMessage(message: inputTextField.text!)
        
        inputTextField.text = nil
        sendButton.isEnabled = false
    }
    
    /*
     lazy var unlinkButton: UIBarButtonItem = {
         let item = UIBarButtonItem(title: "Unlink", style: .plain, target: self, action: #selector(unlink))
         item.tintColor = .red
         return item
     }()
     
     lazy var friendmojiButton = UIBarButtonItem(title: "Friendmoji", style: .plain, target: self, action: #selector(toggleFriendmoji))
     
     
    @objc func unlink() {
        SCSDKLoginClient.unlinkCurrentSession(completion: nil)
    }
    
    @objc func toggleFriendmoji() {
        guard let externalId = externalId else {
            return
        }
        stickerVC.setFriendUserId(externalId)
    }
    
    @objc func toggleStickerViewVisible() {
        isStickerViewVisible = !isStickerViewVisible
    }
    
    private func loadExternalId() {
        SCSDKLoginClient.fetchUserData(
            withQuery: externalIdQuery,
            variables: nil,
            success: { resp in
                guard let resp = resp as? [String : Any],
                      let data = resp["data"] as? [String : Any],
                      let me = data["me"] as? [String : Any],
                      let externalId = me["externalId"] as? String else {
                    return
                }
                DispatchQueue.main.async {
                    self.externalId = externalId
                }
        }, failure: { _, _ in
            print("error")
        })
    }
    
    var isStickerViewVisible = false {
        didSet {
            guard isStickerViewVisible != oldValue else {
                return
            }
            if (isStickerViewVisible == false) {
                inputTextField.inputView = nil
            } else {
                // replace keyboard by snapchat sticker
                inputTextField.inputView = stickerVC.view
            }
            //inputTextField.reloadInputViews()
        }
    }
    
    var bitmojiSearchHasFocus = false {
        didSet {
            guard bitmojiSearchHasFocus != oldValue else {
                return
            }
        }
    }
    */
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView?.contentInset = UIEdgeInsets(top: 10, left: 0, bottom: 10, right: 0)
        collectionView?.alwaysBounceVertical = true // enable vertical scroll
        collectionView?.backgroundColor = UIColor.white
        
        collectionView?.register(ChatMessageViewCell.self, forCellWithReuseIdentifier: cellId)
        
        collectionView?.keyboardDismissMode = .interactive
        
        //navigationItem.rightBarButtonItems = [unlinkButton]
        
        /*
        stickerVC.view.translatesAutoresizingMaskIntoConstraints = false
        stickerVC.delegate = self
        self.addChild(stickerVC)
        stickerVC.didMove(toParent: self)
        
        // add snapchat login status listener
        SCSDKLoginClient.addLoginStatusObserver(self)
        
        if SCSDKLoginClient.isUserLoggedIn {
            loadExternalId()
        }
        */
        
        setupNavigationItems()
        
        if let identifier = room?.identifier {
            SocketService.instance.joinRoom(room: identifier, completion: { (success) in
                if success {
                    self.listenToNewMessages()
                }
            })
        }
        
        NotificationCenter.default.addObserver(self, selector: #selector(handleKeyboardNotification), name: UIResponder.keyboardWillShowNotification, object: nil)
        
        // lock the slide menu
        isMenuLocked(locked: true)
    }
    
    private func setupNavigationItems() {
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "New Post", style: .plain, target: self, action: #selector(handleNewPost))
    }
    
    @objc func handleNewPost() {
        print("tap")
    }
    
    deinit {
        NotificationCenter.default.removeObserver(self)
        
        // unlock the slide menu
        isMenuLocked(locked: false)
    }
    
    private func isMenuLocked(locked: Bool) {
        (UIApplication.shared.keyWindow?.rootViewController as? BaseSlidingController)?.isMenuLocked = locked
    }
    
    @objc func handleKeyboardNotification(notification: NSNotification) {
        print("test")
        UIView.animate(withDuration: 0, delay: 0, options: .curveEaseOut, animations: {
            self.view.layoutIfNeeded()
        }, completion: { (completed) in
            self.scrollToBottom()
        })
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
    }
    
    func listenToNewMessages() {
        SocketService.instance.listenToMessages { (newMessage) in
            
            DispatchQueue.main.async{
                MessageService.instance.messages.append(newMessage)
                
                self.collectionView?.reloadData()
                
                self.scrollToBottom()
            }
        }
    }
    
    func scrollToBottom() {
        if MessageService.instance.messages.count > 0 {
            // scroll at the last index
            let indexPath = IndexPath(item: MessageService.instance.messages.count - 1, section: 0)
            self.collectionView?.scrollToItem(at: indexPath, at: .bottom, animated: true)
        }
    }
    
    override func viewDidDisappear(_ animated: Bool) {
        super.viewDidDisappear(true)
        
        MessageService.instance.clearMessages()
        
        // leave the room
        SocketService.instance.leaveRoom(room: (room?.identifier)!)
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        inputTextField.endEditing(true)
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return MessageService.instance.messages.count
    }
    
    private func estimateFrameForText(text: String) -> CGRect {
        let size = CGSize.init(width: 250, height: 1000)
        let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
        let estimatedFrame = NSString(string: text).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
        return estimatedFrame
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: cellId, for: indexPath) as! ChatMessageViewCell
        
        let message =  MessageService.instance.messages[indexPath.item]
        
        if let picture = message.user?.picture {
            cell.profileImageView.loadImageUsingCache(urlString: picture)
        }
        
        if let messageText = message.text {
            
            cell.messageTextView.text = messageText
            
            let estimatedFrame = estimateFrameForText(text: messageText)
            
            if message.isSender() == true {
                cell.messageTextView.frame = CGRect.init(x: 58 + 8, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                
                cell.textBubbleView.frame = CGRect.init(x: 58, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
                
                cell.profileImageView.isHidden = false
                
                cell.textBubbleView.backgroundColor = UIColor(white: 0.95, alpha: 1)
                cell.messageTextView.textColor = UIColor.black
            } else {
                // outgoing sending message
                
                cell.messageTextView.frame = CGRect.init(x: view.frame.width - estimatedFrame.width - 16 - 16, y: 0, width: estimatedFrame.width + 16, height: estimatedFrame.height + 20)
                
                cell.textBubbleView.frame = CGRect.init(x: view.frame.width - estimatedFrame.width - 16 - 8 - 16, y: 0, width: estimatedFrame.width + 16 + 8, height: estimatedFrame.height + 20)
                
                cell.profileImageView.isHidden = true
                
                cell.textBubbleView.backgroundColor = UIColor(red: 0, green: 137/255, blue: 249/255, alpha: 1)
                cell.messageTextView.textColor = UIColor.white
            }
        }
        
        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let message =  MessageService.instance.messages[indexPath.item]
        
        if let messageText = message.text {
            let size = CGSize.init(width: 250, height: 1000)
            let options = NSStringDrawingOptions.usesFontLeading.union(.usesLineFragmentOrigin)
            let estimatedFrame = NSString(string: messageText).boundingRect(with: size, options: options, attributes: [NSAttributedString.Key.font: UIFont.systemFont(ofSize: 18)], context: nil)
            
            return CGSize.init(width: view.frame.width, height: estimatedFrame.height + 20)
        }
        
        return CGSize.init(width: view.frame.width, height: 100)
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, insetForSectionAt section: Int) -> UIEdgeInsets {
        return UIEdgeInsets(top: 8, left: 0, bottom: 0, right: 0)
    }
}
/*
extension ChatViewController: SCSDKLoginStatusObserver {
    func scsdkLoginLinkDidSucceed() {
        loadExternalId()
    }
}

extension ChatViewController: SCSDKBitmojiStickerPickerViewControllerDelegate {
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController,
                                            didSelectBitmojiWithURL bitmojiURL: String,
                                            image: UIImage?) {
        //handleBitmojiSend(imageURL: bitmojiURL, image: image)
    }
    
    func bitmojiStickerPickerViewController(_ stickerPickerViewController: SCSDKBitmojiStickerPickerViewController, searchFieldFocusDidChangeWithFocus hasFocus: Bool) {
        //bitmojiSearchHasFocus = hasFocus
        if (hasFocus) {
            //inputContainerView.isHidden = true
            //bottomSheetController.showMenu()
            //inputContainerView.isHidden = false
        }
    }
}
*/

extension ChatViewController: UITextFieldDelegate {
    // send a message on press return
    func textFieldShouldReturn(_ textField: UITextField) -> Bool {
        handleSend()
        return true
    }
    
    func textFieldDidBeginEditing(_ textField: UITextField) {
        SocketService.instance.sendStartTypingMessage()
        navigationController?.navigationBar.prefersLargeTitles = false
        //isStickerViewVisible = false
    }
    
    func textFieldDidEndEditing(_ textField: UITextField) {
        SocketService.instance.sendStopTypingMessage()
        navigationController?.navigationBar.prefersLargeTitles = true
    }
}
/*
extension ChatViewController: TouchInterceptingViewDelegate {
    func touchIntercepted(point: CGPoint) {
        let stickerPoint = view.convert(point, to: stickerVC.view)
        if stickerVC.view.hitTest(stickerPoint, with: nil) == nil {
            stickerVC.view.endEditing(true)
        }
    }
}
*/
