//
//  RulesPageTableViewController.swift
//  BoardBuddy
//
//  Created by Hayden Murdock on 5/16/18.
//  Copyright © 2018 Francisco Diarte. All rights reserved.
//

import UIKit
import StoreKit
class RulesPageTableViewController: UITableViewController {
    

    var emptyArray: [Rules] = []
    
    struct Rules {
        var sectionName: String
        var sectionObject: [String]
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.backgroundColor = Colors.blue
        setupNavBar()
        tableView.register(RulesCell.self, forCellReuseIdentifier: "rulesCell")
        for (key, value) in ruleSections {
            emptyArray.append(Rules(sectionName: key, sectionObject: value))
        }
    }

    func setupNavBar() {
        navigationItem.leftBarButtonItem = UIBarButtonItem(title: "Back", style: .done, target: self, action: #selector(backButtonPressed))
        navigationItem.rightBarButtonItem = UIBarButtonItem(title: "Rate Us", style: .plain, target: self, action: #selector(rateUsButtonTapped))
    }
    
    
    @objc func backButtonPressed() {
        self.dismiss(animated: true, completion: nil)
    }
    
    @objc func rateUsButtonTapped() {
        SKStoreReviewController.requestReview()
    }
    override func numberOfSections(in tableView: UITableView) -> Int {
        return emptyArray.count
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return emptyArray[section].sectionObject.count
    }
    
    override  func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return emptyArray[section].sectionName
    }
    
   

    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = RulesCell(style: UITableViewCellStyle.value1, reuseIdentifier: "rulesCell")
        tableView.dequeueReusableCell(withIdentifier: "rulesCell", for: indexPath)
        cell.rules = emptyArray[indexPath.section].sectionObject[indexPath.row]
        cell.backgroundColor = UIColor(red: 38/255, green: 47/255, blue: 69/255, alpha: 1)
        return cell
    }
    
    var ruleSections = ["Objective": ["The object of the game is to become the wealthiest player through buying, renting and selling property"], "Equipment": ["The equipment consists of a board, 2 dice, tokens, 32 houses and 12 hotels. There are Chance and Community Chest cards, a Title Deed card for each property and play money"], "Preperation": ["Place the board on a table and put the Chance and Community Chest cards face down on their allotted spaces on theboard. Each player chooses one token to represent him/her while traveling around the board. Each player is given $1500 divided as follows: 2 each of $500’s, $100’s and $50’s; 6 $20’s; 5 each of $10’s, $5’s and $1’s. All remaining money and other equipment go to the Bank."], "Banker": ["The host is the default Banker. The Banker must keep his/her personal funds separate from those of the Bank. When more than five persons play, the Banker may elect to act only as Banker and Auctioneer."], "The Bank" : ["Besides the Bank’s money, the Bank holds the Title Deed cards and houses and hotels prior to purchase and use by the players. The Bank pays salaries and bonuses. It sells and auctions properties and hands out their proper Title Deed cards; it sells houses and hotels to the players and loans money when required on mortgages. The Bank collects all taxes, fines, loans and interest, and the price of all properties which it sells and auctions."], "The Play":["Starting with the Banker, each player in turn throws the dice. The player with the highest total starts the play: Place your token on the corner marked GO, throw the dice and move your token in the direction of the arrow the number of spaces indicated by the dice. After you have completed your play, the turn passes to the left. The tokens remain on the spaces occupied and proceed from that point on the player’s next turn. Two or more tokens may rest on the same space at the same time. According to the space your token reaches, you may be entitled tobuy real estate or other properties — or obliged to pay rent, pay taxes, draw a Chance or Community Chest card, Go to Jail, etc. If you throw doubles, you move your token as usual, the sum of the two dice, and are subject to any privileges or penalties pertaining to the space on which you land. Retaining the dice, throw again andmove your token as before. If you throw doubles three times in succession, move your token immediately to the space marked In Jail(see JAIL)."], "G0": ["Each time a player’s token lands on or passes over GO, whether by throwing the dice or drawing a card, the Banker pays him/her a $200 salary.The $200 is paid only once each time around tboard. However, if a player passing GO on the throw of the dice lands 2 spaces beyond it on Community Chest, or 7 spaces beyond it on Chance, and draws the Advance to GO card, he/she collects $200 for passing GO the first time and another $200 for reaching it the second time by instructions on the card."], "Buying Property": ["Whenever you land on an unowned property you may buy that property from the Bank at its printed price. You receive the Title Deed card showing ownership; place it face up in front of you. If you do not wish to buy the property, the Banker sells it at auction to the highest bidder. The buyer pays the Bank the amount of the bid in cash and receives the Title Deed card for that property. Any player, including the one who declined the option to buy it at the printed price, may bid. Bidding may start at any price"],"Paying Rent": ["When you land on property owned by another player, the owner collects rent from you in accordance with the list printed on its Title Deed card. If the property is mortgaged, no rent can be collected. When a property is mortgaged, its Title Deed card is placed face down in front of the owner. It is an advantage to hold all the Title Deed cards in a color-group (e.g., Boardwalk and Park Place; or Connecticut, Vermont and Oriental Avenues) because the owner may then charge double rent for unimproved properties in that color-group. This rule applies to unmortgaged properties even if another property in that color-groupis mortgaged. It is even more advantageous to have houses or hotels on properties because rents are much higher than for unimproved properties. The owner may not collect the rent if he/she fails to ask for it before the second player following throws the dice."], "Chance & Community Chests": ["When you land on either of these spaces, take the top card from the deck indicated, follow the instructions and return the card face down to the bottom of the deck.\n The Get Out of Jail Free card is held until used and then returned to the bottom of the deck. If the player who draws it does not wish to use it, he/she may sell it, at any time, to another player at a price agreeable to both."],"Income Tax": ["If you land here you have two options: You may estimate your tax at $200 and pay the Bank, or you may pay 10% of your total worth to the Bank. Your total worth is all your cash on hand, printed prices of mortgaged and unmortgaged properties and cost price of all buildings you own. You must decide which option you will take before you add up your total worth"], "Jail": ["You land in Jail when... (1) your token lands on the space marked Go to Jail; (2) you draw a card marked Go to Jail; or (3) you throw doubles three times in succession. When you are sent to Jail you cannot collect your $200 salary in that move since, regardless of where your token is on the board, you must move it directly into Jail. Yours turn ends when you are sent to Jail. If you are not sent to Jail but in the ordinary course of play land on that space, you are “Just Visiting,you incur no penalty, and you move ahead in the usual manner on your next turn. You get out of Jail by... (1) throwing doubles on any of your next three turns; if you succeed in doing this you immediately move forward the number of spaces shown by your doubles throw; even though you had thrown doubles, you do not take another turn; (2) using the Get Out of Jail Free card if you have it; (3) purchasing the Get Out of Jail Free card from another player and playing it; (4) paying a fine of $50 before you roll the dice on either of your next two turns. If you do not throw doubles by your third turn, you must pay the $50 fine. You then get out of Jail and immediately move forward the number of spaces shown by your throw. Even though you are in Jail, you may buy and sell property, buyand sell houses and hotels and collect rents."], "Free Parking": ["A player landing on this place does not receive any money, property or reward of any kind. This is just a “free” resting place."],"Houses": ["When you own all the properties in a color-group you may buy houses from the Bank and erect them on those properties. If you buy one house, you may put it on any one of those properties. The next house you buy must be erected on one of the unimproved properties of this or any other complete color-group you may own. The price you must pay the Bank for each house is shown on your Title Deed card for the property on which you erect the house.\n The owner still collects double rent from an opponent who lands on the unimproved properties of his/her complete color-group.\n Following the above rules, you may buy and erect at any time as many houses as your judgement and financial standing will allow. But you must build evenly, i.e., you cannot erect more than one house on any one property of any color-group until you have built one house on every property of that group. You may then begin on the second row of houses, and so on, up to a limit of four houses to a property. For example, you cannot build three houses on one property if you have only one house on another property of that group. As you build evenly, you must also break down evenly if you sell houses back to the Bank (see SELLING PROPERTY)."], "Hotels": [" When a player has four houses on each property of a complete color-group, he/she may buy a hotel from the Bank and erect it on any property of the color-group. He/she returns the four houses from that property to the Bank and pays the price for the hotel as shown on the Title Deed card. Only one hotel may be erected on any one property."], "Building Shortages": ["When the Bank has no houses to sell, players wishing to build must wait for some player to return or sell his/her houses to the Bank before building. If there are a limited number of houses and hotels available and two or more players wish to buy more than the Bank has, the houses or hotels must be sold at auction to the highest bidder."],"Selling Property": ["Unimproved properties, railroads and utilities (but not buildings) may be sold to any player as a private transaction for any amount the owner can get; however, no property can be sold to another player if buildings are standing on any properties of that color-group. Any buildings so located must be sold back to the Bank before the owner can sell any property of that color-group. Houses and hotels may be sold back to the Bank at any time for one-half the price paid for them. All houses on one color-group must be sold one by one, evenly, in reverse of the manner in which they were erected.All hotels on one color-group may be sold at once, or they may be sold one house at a time (one hotel equals five houses), evenly, in reverse of the manner in which they were erected."], "Mortgages": ["Unimproved properties can be mortgaged through the Bank at any time. Before an improved property can be mortgaged, all the buildings on all the properties of its color-group must be sold back to the Bank at half price. The mortgage value is printed on each Title Deed card. No rent can be collected on mortgaged properties or utilities, but rent can be collected on unmortgaged properties in the same group. In order to lift the mortgage, the owner must pay the Bank the amount of the mortgage plus 10% interest. When all the properties of a color-group are no longer mortgaged, the owner may begin to buy back houses at full price. The player who mortgages property retains possession of it and no other player may secure it by lifting the mortgage from the Bank.However, the owner may sell this mortgaged property to another player at any agreed price. If you are the new owner, you may lift the mortgage at once if you wish by paying off the mortgage plus 10% interest to the Bank. If the mortgage is not lifted at once, you must pay the Bank 10% interest when you buy the property and if you lift the mortgage later you must pay the Bank an additional 10% interest as well as the amount of the mortgage."],"Bankruptcy":["ou are declared bankrupt if you owe more than you can pay either to another player or to the Bank. If your debt is to another player, you must turn over to that player all that you have of value and retire from the game. In making this settlement, if you own houses or hotels, you must return these to the Bank in exchange for money to the extent of one-half the amount paid for them; this cash is given to the creditor. If you have mortgaged property you also turn this property over to your creditor but the new owner must at once pay the Bank the amount of interest on the loan, which is 10% of the value of the property. The new owner who does this may then, at his/her option, pay the principal or hold the property until some later turn, then lift the mortgage. If he/she holds property in this way until a later turn, he/she must pay the interest again upon lifting the mortgage.Should you owe the Bank, instead of another player, more than you can pay (because of taxes or penalties) even by selling off buildings and mortgaging property, you must turn over all assets to the Bank. In this case, the Bank immediately sells by auction all property so taken, except buildings. A bankrupt player must immediately retire from the game. The last player left in the game wins."],"Misc..":["Money can be loaned to a player only by the Bank and then only by mortgaging property. No player may borrow from or lend money to another player."]
    ]
}
