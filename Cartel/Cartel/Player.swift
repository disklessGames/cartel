
import Foundation

class Player {
    var name: String
    var hand: [Card]
    
    init(name: String){
        self.name = name
        self.hand = [Card]()
    }
}
