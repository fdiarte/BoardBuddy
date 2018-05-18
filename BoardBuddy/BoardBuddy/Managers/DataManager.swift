//
//  DataManager.swift
//  BoardBuddy
//
//  Created by Francisco Diarte on 5/14/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit

class DataManager {
    static let shared = DataManager()
    
    func encodePlayer(player: Player) -> Data? {
        do {
            let encodedPlayer = try JSONEncoder().encode(player)
            return encodedPlayer
        } catch {
            print("Error encoding player: \(error.localizedDescription)")
        }
        return nil
    }
    
    func decodePlayer(from data: Data) -> Player? {
        do {
            let player = try JSONDecoder().decode(Player.self, from: data)
            return player
        } catch {
            print("Error decoding player: \(error.localizedDescription)")
            return nil
        }
    }
    
    func encodeBanker(banker: Banker) -> Data? {
        do {
            let encodedBanker = try JSONEncoder().encode(banker)
            return encodedBanker
        } catch {
            print("Error encoding banker: \(error.localizedDescription)")
            return nil
        }
    }
    
    func decodBanker(from data: Data) -> Banker? {
        do {
            let banker = try JSONDecoder().decode(Banker.self, from: data)
            return banker
        } catch {
            print("Error decoding Banker: \(error.localizedDescription)")
            return nil
        }
    }
    
    func encodeImage(from image: UIImage) -> Data? {
        guard let imageData: Data = UIImagePNGRepresentation(image) else {
            print("Cannot convert image to data")
            return nil
        }
        return imageData
    }
    
    func decodeImage(from data: Data) -> UIImage? {
        guard let image = UIImage(data: data) else {
            print("Cannot conver data to image")
            return nil
        }
        return image
    }
    
    func encodeSendingInfo(from info: SendingInfo) -> Data? {
        do {
            let encodedInfo = try JSONEncoder().encode(info)
            return encodedInfo
        } catch {
            print("Cant convert info to data")
            return nil
        }
    }
    
    func decodeSendingInfo(from data: Data) -> SendingInfo? {
        do {
            let info = try JSONDecoder().decode(SendingInfo.self, from: data)
            return info
        } catch {
            print("Cant decode info: \(error)")
            return nil
        }
    }
    
    func encodePlayers(from players: [Player]) -> Data? {
        do {
            let encodedPlayers = try JSONEncoder().encode(players)
            return encodedPlayers
        } catch {
            print("Couldnt encode players")
            return nil
        }
    }
    
    func decodePlayers(from data: Data) -> [Player]? {
        do {
            let decodedPlayers = try JSONDecoder().decode([Player].self, from: data)
            return decodedPlayers
        } catch {
            print("Couldnt decode players")
            return nil
        }
    }
    
    func encodeRequest(request: RequestFunds) -> Data? {
        do {
            let encodedRequest = try JSONEncoder().encode(request)
            return encodedRequest
        } catch {
            print("Couldnt encode request")
            return nil
        }
    }
    
    func decodeRequest(from data: Data) -> RequestFunds? {
        do {
            let decodedRequest = try JSONDecoder().decode(RequestFunds.self, from: data)
            print("Successfully decoded request")
            return decodedRequest
        } catch {
            print("Couldnt decode request")
            return nil
        }
    }
    
    func encodeAcceptFunds(acceptFunds: AcceptFunds) -> Data? {
        do {
            let encodedAcceptRequest = try JSONEncoder().encode(acceptFunds)
            return encodedAcceptRequest
        } catch {
            print("Couldnt encode accept request")
            return nil
        }
    }
    
    func decodeAcceptFunds(from data: Data) -> AcceptFunds? {
        do {
            let decodeAcceptFunds = try JSONDecoder().decode(AcceptFunds.self, from: data)
            return decodeAcceptFunds
        } catch {
            print("Couldnt decode accept request")
            return nil
        }
    }
    
    
    
}



