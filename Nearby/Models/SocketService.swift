//
//  ChatRoom.swift
//  Nearby
//
//  Created by Sebastien Menozzi on 29/12/2018.
//  Copyright © 2018 Sebastien Menozzi. All rights reserved.
//

import Foundation
import SocketIO
import SwiftKeychainWrapper

class SocketService: NSObject {
    
    static let instance = SocketService()
    
    var manager: SocketManager!
    var socket: SocketIOClient!
    
    override init() {
        super.init()
        
        // retrieve the token in the keychain
        let token: String = KeychainWrapper.standard.string(forKey: "userToken")!
        
        self.manager = SocketManager(socketURL: URL(string: "http://192.168.1.8:3000")!, config: [.log(true), .compress, .connectParams(["token": token])])
        self.socket = self.manager?.defaultSocket
        
        listenToSocketEvent()
    }
    
    func establishConnection() {
        self.socket.connect()
    }
    
    func closeConnection() {
        self.socket.disconnect()
    }
    
    func listenToSocketEvent() {
        self.socket.on(clientEvent: .connect) {data, ack in
            print("You are connected to the chat!")
        }
        
        self.socket.on(clientEvent: .error) {data, ack in
            print("You have been disconnected!")
        }
    }
    
    func listenToMessages(completion: @escaping (_ newMessage: Message) -> Void) {
        self.socket.on("new_message") { (data, ack) -> Void in
            guard let json = data[0] as? [String: Any] else { return }
            
            completion(Message(dictionary: json))
        }
    }
    
    func joinRoom(room: String, completion: @escaping CompletionHandler) {
        self.socket.emit("join_room", room)
        completion(true)
    }
    
    func leaveRoom(room: String) {
        self.socket.off("new_message")
        self.socket.emit("leave_room", room)
    }
    
    func sendMessage(message: String) {
        self.socket.emit("new_message", message)
    }
    
    func sendStartTypingMessage() {
        socket.emit("startType")
    }
    
    func sendStopTypingMessage() {
        socket.emit("stopType")
    }
}
