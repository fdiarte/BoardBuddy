//
//  MPCManager.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/15/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import Foundation
import MultipeerConnectivity

protocol MPCManagerDelegate {
    func playerJoinedSession()
    func playerRecieved(from data: Data)
    func playersArrayRecieved(from data: Data)
    func requestFundsRecieved(from data: Data)
    func acceptedFundsRecieved(from data: Data)
    func matchEndedRecieved(from data: Data)
    func sessionNotConnected()
    func readyInfoRecieved(from data: Data)
    func playerLeft(from data: Data)
}

class MPCManager: NSObject, MCSessionDelegate {
    
    // MARK: - Shared Instance
    static var shared = MPCManager()
    
    // MARK: - Properties
    var delegate: MPCManagerDelegate?
    var session: MCSession!
    var peerID: MCPeerID!
    var browser: MCBrowserViewController!
    var advertiser: MCNearbyServiceAdvertiser!
    var advertiserAssistant: MCAdvertiserAssistant!
    var currentGamePeers = [MCPeerID]()
    
    // MARK: - Manager Initializer
    override init() {
        super.init()
        
        let displayName = PlayerController.shared.players.first?.displayName
        
        if let displayName = displayName {
            peerID = MCPeerID(displayName: displayName)
        } else {
            peerID = MCPeerID(displayName: UIDevice.current.name)
        }
        
        // May need to change
        session = MCSession(peer: peerID, securityIdentity: nil, encryptionPreference: .required)
        session.delegate = self
        
        currentGamePeers.append(peerID)
        
        browser = MCBrowserViewController(serviceType: "BoardBuddy", session: session)
        advertiserAssistant = MCAdvertiserAssistant(serviceType: "BoardBuddy", discoveryInfo: nil, session: session)
    }

    
    // MARK: - MCSession delegate functions
    
    func session(_ session: MCSession, peer peerID: MCPeerID, didChange state: MCSessionState) {
        switch state{
        case MCSessionState.connected:
            print("Connected to session")
            currentGamePeers.append(peerID)
            delegate?.playerJoinedSession()
            
        case MCSessionState.connecting:
            print("Connecting to session")
      
        default:
            print("Did not connect to session")
            delegate?.sessionNotConnected()
        }
    }
    
    func session(_ session: MCSession, didReceive data: Data, fromPeer peerID: MCPeerID) {
        // turn data to person object
        delegate?.playerRecieved(from: data)
        delegate?.playersArrayRecieved(from: data)
        delegate?.requestFundsRecieved(from: data)
        delegate?.acceptedFundsRecieved(from: data)
        delegate?.matchEndedRecieved(from: data)
        delegate?.readyInfoRecieved(from: data)
        delegate?.playerLeft(from: data)
    }
    
    func session(_ session: MCSession, didReceive stream: InputStream, withName streamName: String, fromPeer peerID: MCPeerID) {
        // Nothing to do here
    }
    
    func session(_ session: MCSession, didStartReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, with progress: Progress) {
        // Nothing to do here
    }
    
    func session(_ session: MCSession, didFinishReceivingResourceWithName resourceName: String, fromPeer peerID: MCPeerID, at localURL: URL?, withError error: Error?) {
        // Nothing to do here
    }
    
    func stopSession() {
        session.disconnect()
        advertiserAssistant.stop()
        print(currentGamePeers.count)
        for peer in currentGamePeers {
            if peer != currentGamePeers.first {
                guard let index = currentGamePeers.index(of: peer) else { return }
                currentGamePeers.remove(at: index)
            }
        }
    }
    
    func playerDisconnected(player: Player) {
        for (index,peer) in currentGamePeers.enumerated() {
            if peer.displayName == player.displayName {
                currentGamePeers.remove(at: index)
            }
        }
        session.disconnect()
    }
    
    func sendPerson(player: Player) {
        guard let data = DataManager.shared.encodePlayer(player: player) else { print("nothing here"); return }
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print("Cant send player: \(error.localizedDescription)")
        }
    }
    
    func sendPlayers(players: [Player]) {
        guard let data = DataManager.shared.encodePlayers(from: players) else { print("Error encoding players"); return }
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            print("Successfully sent players")
            print(session.connectedPeers)
        } catch {
            print("Cant send players \(error.localizedDescription): \(error)")
        }
    }
    
    func sendRequestFunds(request: RequestFunds, to playerToSend: Player) {
        guard let data = DataManager.shared.encodeRequest(request: request) else { return }
        var index = 0
        for (arrayIndex,peer) in currentGamePeers.enumerated() {
            if playerToSend.displayName == peer.displayName {
                index = arrayIndex
            }
        }
        
        do {
            try session.send(data, toPeers: [currentGamePeers[index]], with: .reliable)
            print("Successfully sent info")
        } catch {
            print("Cant send request for funds: \(error.localizedDescription)")
        }
    }
    
    func sendAcceptedFunds(acceptedFunds: AcceptFunds, to playerToSend: Player) {
        guard let data = DataManager.shared.encodeAcceptFunds(acceptFunds: acceptedFunds) else { return }
  
        var index = 0
        for (arrayIndex,peer) in currentGamePeers.enumerated() {
            if playerToSend.displayName == peer.displayName {
                index = arrayIndex
            }
        }
        
        do {
            try session.send(data, toPeers: [currentGamePeers[index]], with: .reliable)
        } catch {
            print("Cant send accepted funds: \(error.localizedDescription)")
        }
    }
    
    func sendMatchEnded(matchEnded: MatchEnded) {
        guard let data = DataManager.shared.encodeMatchEnd(matchEnd: matchEnded) else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
            print(session.connectedPeers)
        } catch {
            print("Cant send match end: \(error.localizedDescription)")
        }
    }
    
    func sendReadyInfo(readyInfo: ReadyInfo) {
        guard let data = DataManager.shared.encodeReadyInfo(readyInfo: readyInfo) else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print("Cant send ready info: \(error.localizedDescription)")
        }
    }
    
    func sendPlayerLeftInfo(playerLeftInfo: PlayerLeftInfo) {
        guard let data = DataManager.shared.encodePlayerLeftInfo(playerLeftInfo: playerLeftInfo) else { return }
        
        do {
            try session.send(data, toPeers: session.connectedPeers, with: .reliable)
        } catch {
            print("Cant send ready info: \(error.localizedDescription)")
        }
    }
}
