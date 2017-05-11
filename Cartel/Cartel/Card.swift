
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
    
    var image: UIImage {
        get {
            switch self {
            case .straight :
                return UIImage(named: "RoadCardStraight.png")!
            case .tJunction :
                return UIImage(named: "RoadCardTJunction.png")!
            case .leftTurn :
                return UIImage(named: "RoadCardLeftTurn.png")!
            case .rightTurn :
                return UIImage(named: "RoadCardRightTurn.png")!
            }
        }
    }
}

enum PocketCardType {
    case snitch
    case detectiveTracy
    case informantFivel
    case inspectorFord
    case sneakySven
    case captainJuan
    case wardenSachs
    case congressmanTu
    
    var image: UIImage {
        switch self {
        case .snitch:
            return UIImage(named: "PocketSnitch")!
        case .detectiveTracy:
            return UIImage(named: "PocketDetectiveTracy.png")!
        case .informantFivel:
            return UIImage(named: "PocketInformantFivel.png")!
        case .inspectorFord:
            return UIImage(named: "PocketInspectorFord.png")!
        case .sneakySven:
            return  UIImage(named: "PocketSneakySven.png")!
        case .captainJuan:
            return UIImage(named: "PocketCaptainJuan.png")!
        case .wardenSachs:
            return UIImage(named: "PocketWardenSachs.png")!
        case .congressmanTu:
            return UIImage(named: "PocketCongressmanTu.png")!
        }
        
    }
}

enum BuildingCardType {
    case anniewares
    case topTech
    case doubleDown
    case groundhogCoffees
    case efficientConsulting
    case lucyLaundromat
    case mannedManagement
    case neueNewsNetwork
    case privateSecurity
    case shelfCorp
    case skyline
    
    var image: UIImage {
        switch self {
        case .anniewares : return UIImage(named: "BuildingAnnie.png")!
        case .doubleDown : return UIImage(named: "BuildingDoubleDown.png")!
        case .topTech : return UIImage(named: "BuildingTopTech.png")!
        case .groundhogCoffees : return UIImage(named: "BuildingGroundhog.png")!
        case .efficientConsulting : return UIImage(named: "BuildingEfficientConsulting.png")!
        case .lucyLaundromat : return UIImage(named: "BuildingLucyLaundromat.png")!
        case .mannedManagement : return UIImage(named: "BuildingMannedManagement.png")!
        case .neueNewsNetwork : return UIImage(named: "BuildingNeueNewsNetwork.png")!
        case .privateSecurity : return UIImage(named: "BuildingPrivateSecurity.png")!
        case .shelfCorp : return UIImage(named: "BuildingShelfCorp.png")!
        case .skyline : return UIImage(named: "BuildingSkyline.png")!
        }
    }
}

class Card: NSObject {
    
    static let smallSize = CGSize(width: 100, height: 150)
    static let bigSize = CGSize(width: 150, height: 225)

    var type: CardType
    var name = "None"
    var wealthValue = 0
    var image: UIImage {
        if let road = road {
            return road.image
        }
        if let building = building {
            return building.image
        }
        if let pocket = pocket {
            return pocket.image
        }
        return UIImage()
    }
    var building: BuildingCardType?
    var road: RoadCardType?
    var pocket: PocketCardType?
    
    init(_ type: CardType){
        self.type = type
    }
    
    convenience init(_ building: BuildingCardType) {
        self.init(.building)
        self.building = building
        //        self.init(.building)
    }
    
    convenience init(_ road: RoadCardType) {
        self.init(.road)
        self.road = road
    }
    
    convenience init(_ pocket: PocketCardType) {
        self.init(.pocket)
        self.pocket = pocket
    }
}
