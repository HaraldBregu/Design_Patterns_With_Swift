import UIKit

protocol Administration {
    var postOfficeName: String { get }
    var superMarketName: String { get }
    func show()
}

extension Administration {
    
    var postOfficeName: String {
        return "The Central Office"
    }
   
    var superMarketName: String {
        return "LIDL"
    }
    
    func show() {
        print("My city had a post office name: \(postOfficeName) and a supermarket with name: \(superMarketName)")
    }

}

class City: Administration {

    init() {
        show()
    }
    
}

City()
