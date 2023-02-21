import UIKit
import Foundation

/// SINGLETON
final class Sun {
    static let shared = Sun()
    var dimension: Double!
    
    private init() {}
}

/// PRINT SINGLETON
var sun = Sun.shared
sun.dimension = 345
print(sun.dimension ?? "")

var sameSun = Sun.shared
print(sameSun.dimension ?? "")
sameSun.dimension = 56
print(sameSun.dimension ?? "")
