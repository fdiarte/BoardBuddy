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
    
    func encodeMatchEnd(matchEnd: MatchEnded) -> Data? {
        do {
            let encodedMatchEnd = try JSONEncoder().encode(matchEnd)
            return encodedMatchEnd
        } catch {
            print("Couldnt encode match end")
            return nil
        }
    }
    
    func decodeMatchEnd(from data: Data) -> MatchEnded? {
        do {
            let decodedMatchEnd = try JSONDecoder().decode(MatchEnded.self, from: data)
            return decodedMatchEnd
        } catch {
            print("Couldnt decode match end")
            return nil
        }
    }
    
    func encodeReadyInfo(readyInfo: ReadyInfo) -> Data? {
        do {
            let encodedReadyInfo = try JSONEncoder().encode(readyInfo)
            return encodedReadyInfo
        } catch {
            print("Couldnt encode ready info")
            return nil
        }
    }
    
    func decodeReadyInfo(from data: Data) -> ReadyInfo? {
        do {
            let decodedReadyInfo = try JSONDecoder().decode(ReadyInfo.self, from: data)
            return decodedReadyInfo
        } catch {
            print("Couldnt decode ready info")
            return nil
        }
    }
    
    func encodePlayerLeftInfo(playerLeftInfo: PlayerLeftInfo) -> Data? {
        do {
            let encodePlayerLeftInfo = try JSONEncoder().encode(playerLeftInfo)
            return encodePlayerLeftInfo
        } catch {
            print("Couldnt encode player left info")
            return nil
        }
    }
    
    func decodePlayerLeftInfo(from data: Data) -> PlayerLeftInfo? {
        do {
            let decodePlayerLeftInfo = try JSONDecoder().decode(PlayerLeftInfo.self, from: data)
            return decodePlayerLeftInfo
        } catch {
            print("Couldnt decode player left info")
            return nil
        }
    }
}
