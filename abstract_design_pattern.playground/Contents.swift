import UIKit


protocol Garage {
    func createCar() -> Car?
    func createMotorcycle() -> Motorcycle?
}

protocol Car {
    var type: String { get set }
    func start()
}

protocol Motorcycle {
    var type: String { get set }
    func start()
}

class MotorMagazine: Garage {
    
    func createCar() -> Car? {
        return SportsCar(type: "Ferrari")
    }
    
    func createMotorcycle() -> Motorcycle? {
        return SportsMotorcycle(type: "Yamaha")
    }
    
}

private struct SportsCar: Car {
    var type: String
    
    func start() {
        print("Starting a \(type) car")
    }
}

private struct SportsMotorcycle: Motorcycle {
    var type: String
    
    func start() {
        print("Starting a \(type) motorcycle")
    }
}

class MyGarage: Garage {
    
    func createCar() -> Car? {
        return MyFavoriteCar(type: "Mercedes")
    }
    
    func createMotorcycle() -> Motorcycle? {
        return MyFavoriteMotorcycle(type: "Honda CBR")
    }

}

private struct MyFavoriteCar: Car {
    var type: String
    
    func start() {
        print("I like to drive my \(type)")
    }
}

private struct MyFavoriteMotorcycle: Motorcycle {
    var type: String
    
    func start() {
        print("I like to drive fast with my \(type)")

    }
}


let motorMagazine = MotorMagazine()
motorMagazine.createCar()?.start()
motorMagazine.createMotorcycle()?.start()


let myGarage = MyGarage()
myGarage.createCar()?.start()
myGarage.createMotorcycle()?.start()
