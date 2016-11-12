
import Foundation
import UIKit

enum CardType {
    case none
    case road
    case pocket
    case building
}

enum RoadCardType {
    case straight
    case tJunction
    case leftTurn
    case rightTurn
}

enum PocketCardType:Int{
    case snitch
    case detectiveTracy
    case informantFivel
    case inspectorFord
    case sneakySven
    case captainJuan
    case wardenSachs
    case congressmanTu
}

enum BuildingCardType:Int{
    case anniewares = 1
    case topTech,doubleDown,groundhogCoffees,efficientConsulting,lucyLaundromat,mannedManagement,neueNewsNetwork,privateSecurity,shelfCorp,skyline
}

class Card: NSObject {
    var card: CardType
    var name = "None"
    var wealthValue = 0
    var image: UIImage
        
    init(type: CardType){
        self.card = type
        image = UIImage(named: "CardBack.png")!
    }
}

class RoadCard : Card {
    var type: RoadCardType
    
    init(type:RoadCardType){
        self.type = type
        super.init(type: CardType.road)
        switch type {
        case .straight : self.image = UIImage(named: "RoadCardStraight.png")!
        case .tJunction : self.image = UIImage(named: "RoadCardTJunction.png")!
        case .leftTurn : self.image = UIImage(named: "RoadCardLeftTurn.png")!
        case .rightTurn : self.image = UIImage(named: "RoadCardRightTurn.png")!
    
        }
    }
}



class PocketCard : Card {
    var pocketType:PocketCardType
    
    init(pocketType: PocketCardType){
        self.pocketType = pocketType
        super.init(type: CardType.pocket)
        switch self.pocketType {
        case .snitch: self.image =  UIImage(named: "PocketSnitch")!
        case .detectiveTracy: self.image =  UIImage(named: "PocketDetectiveTracy.png")!
        case .informantFivel: self.image =  UIImage(named: "PocketInformantFivel.png")!
        case .inspectorFord: self.image =  UIImage(named: "PocketInspectorFord.png")!
        case .sneakySven: self.image =  UIImage(named: "PocketSneakySven.png")!
        case .captainJuan: self.image =  UIImage(named: "PocketCaptainJuan.png")!
        case .wardenSachs: self.image =  UIImage(named: "PocketWardenSachs.png")!
        case .congressmanTu: self.image =  UIImage(named: "PocketCongressmanTu.png")!
        }
        
    }
}


class BuildingCard : Card {
    var type:BuildingCardType
    
    init(buildingType:BuildingCardType){
        self.type = buildingType
        super.init(type: CardType.building)
        switch buildingType {
        case .anniewares : self.image = UIImage(named: "BuildingAnnie.png")!
        case .doubleDown : self.image = UIImage(named: "BuildingDoubleDown.png")!
        case .topTech : self.image = UIImage(named: "BuildingTopTech.png")!
        case .groundhogCoffees : self.image = UIImage(named: "BuildingGroundhog.png")!
        case .efficientConsulting : self.image = UIImage(named: "BuildingEfficientConsulting.png")!
        case .lucyLaundromat : self.image = UIImage(named: "BuildingLucyLaundromat.png")!
        case .mannedManagement : self.image = UIImage(named: "BuildingMannedManagement.png")!
        case .neueNewsNetwork : self.image = UIImage(named: "BuildingNeueNewsNetwork.png")!
        case .privateSecurity : self.image = UIImage(named: "BuildingPrivateSecurity.png")!
        case .shelfCorp : self.image = UIImage(named: "BuildingShelfCorp.png")!
        case .skyline : self.image = UIImage(named: "BuildingSkyline.png")!
        }
    }
}
