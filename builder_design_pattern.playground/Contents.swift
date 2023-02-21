import Foundation


enum HouseType {
    case home
    case villa
}

struct House {
    var type: HouseType!
    var garden: Garden!
    var pool: Pool!
    var plants:[Plant]!
    
    init() {}
}

struct Garden {
    var length: Double
    var width: Double
}

struct Pool {
    var length: Double
    var width: Double
}

enum PlantType {
    case tree
    case flower
}

struct Plant {
    var type: PlantType
}

class HouseBuilder {
    var house = House()
    
    static func create() -> HouseBuilder {
        let houseBuilder = HouseBuilder()
        
        return houseBuilder
    }
    
    func setType(type: HouseType) -> HouseBuilder {
        house.type = type
        
        return self
    }
    
    func add(garden: Garden) -> HouseBuilder{
        house.garden = garden

        return self
    }
    
    func add(pool: Pool) -> HouseBuilder {
        house.pool = pool
        
        return self
    }
    
    func add(plants: [Plant]) -> HouseBuilder {
        house.plants = plants
        
        return self
    }
    
    func printFullHouse() -> HouseBuilder {
        switch house.type {
        case .home:
            print("House type is home")
        case .villa:
            print("House type is villa")
        default:
            print("-")
        }
        print("garden width: \(house.garden.width) - length: \(house.garden.length)")
        print("pool width: \(house.pool.width) - length: \(house.pool.length)")
        print("plants count: \(house.plants.count)")

        return self
    }
}

/// Here is the builder
HouseBuilder.create()
    .setType(type: HouseType.villa)
    .add(garden: Garden(length: 123, width: 450))
    .add(pool: Pool(length: 87, width: 65))
    .add(plants: [
        Plant(type: PlantType.tree),
        Plant(type: PlantType.tree),
        Plant(type: PlantType.flower),
    ])
    .printFullHouse()
