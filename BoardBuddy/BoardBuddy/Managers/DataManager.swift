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
}



