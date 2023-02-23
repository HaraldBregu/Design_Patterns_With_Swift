import UIKit

class Car {
    func start() {
        print("Starting the car.")
    }
    
    func stop() {
        print("Stopping the car.")
    }
}

class AirConditioner {
    func turnOn() {
        print("Turning on the air conditioner.")
    }
    
    func turnOff() {
        print("Turning off the air conditioner.")
    }
}

class Radio {
    func turnOn() {
        print("Turning on the radio.")
    }
    
    func turnOff() {
        print("Turning off the radio.")
    }
    
    func setStation(_ station: String) {
        print("Setting the radio station to \(station).")
    }
}

class CarSystem {
    let car = Car()
    let airConditioner = AirConditioner()
    let radio = Radio()
    
    func startCar() {
        car.start()
        airConditioner.turnOn()
        radio.turnOn()
        radio.setStation("FM 102.5")
    }
    
    func stopCar() {
        radio.turnOff()
        airConditioner.turnOff()
        car.stop()
    }
}

// Usage
let carSystem = CarSystem()
carSystem.startCar() // Starting the car. Turning on the air conditioner. Turning on the radio. Setting the radio station to FM 100.5.
carSystem.stopCar() // Turning off the radio. Turning off the air conditioner. Stopping the
