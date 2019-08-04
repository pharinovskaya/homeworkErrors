import Foundation

enum AutoErrors: Error {
    case headlights
    case doors
    case akk
    case petrol(km:Int)
    case belts
}

class Auto {
    var headlightsOff: Bool
    var doorClosed: Bool
    var akkKaput: Bool
    var engine: Bool
    
    func blockCar() throws {
        guard headlightsOff else {
            throw AutoErrors.headlights
        }
        guard doorClosed else {
            throw AutoErrors.doors
        }
        print ("Car is blocked!")
    }
    
    func engineOn() throws {
        if engine {
            print("the car is already running")
        } else {
            guard !(akkKaput) else {
                throw AutoErrors.akk
            }
        }
        print("Oh yes! The car begins running now")
    }
    
    var hasPetrol: Bool
    var kmLeft: Int
    var beltFastened: Bool
    
    func riding(km: Int) throws -> Int {
        guard beltFastened else {
            throw AutoErrors.belts
        }
        guard hasPetrol && km <= kmLeft else {
            throw AutoErrors.petrol(km: km)
        }
        print("Oh yes! You can riding! Petrol is left dor \(kmLeft - km) kilometers")
        kmLeft -= km
        return kmLeft
    }
    
    var isWashed: Bool
    func washing() {
        if isWashed {
            print("You don't need car waching!")
        } else {
            print("Car's is washing")
        }
          isWashed = true
        print ("Car was washed!")
    }
    
    init(headlightsOff: Bool, doorClosed: Bool, akkKaput: Bool, engine: Bool, hasPetrol: Bool, kmLeft: Int, beltFastened: Bool, isWashed: Bool) {
        self.headlightsOff = headlightsOff
        self.doorClosed = doorClosed
        self.akkKaput = akkKaput
        self.engine = engine
        self.hasPetrol = hasPetrol
        self.kmLeft = kmLeft
        self.beltFastened = beltFastened
        self.isWashed = isWashed
    }
    /*
    init(headlightsOff: Bool = true, doorClosed: Bool = true, akkKaput: Bool = false, engine: Bool = true, hasPetrol: Bool = true, beltFastened: Bool = true, kmLeft: Int = 100, isWashed: Bool = true) {
    }*/
}

var myAuto = Auto(headlightsOff: true, doorClosed: false, akkKaput: false, engine: false, hasPetrol: true, kmLeft: 100, beltFastened: false, isWashed: false)

do {
    try myAuto.blockCar()
} catch AutoErrors.doors {
    print("Please, close door(s)!")
} catch AutoErrors.headlights {
    print("Please, make off headlights!")
}

myAuto.doorClosed = true

do {
    try myAuto.blockCar()
} catch AutoErrors.doors {
    print("Please, close door(s)!")
} catch AutoErrors.headlights {
    print("Please, make off headlights!")
}

myAuto.headlightsOff = false
do {
    try myAuto.blockCar()
} catch AutoErrors.doors {
    print("Please, close door(s)!")
} catch AutoErrors.headlights {
    print("Please, make off headlights!")
}

myAuto.washing()

do {
    try myAuto.engineOn()
} catch AutoErrors.akk {
    print("Oh no! Your akk is KAPUT!")
}

myAuto.akkKaput = true

do {
    try myAuto.engineOn()
} catch AutoErrors.akk {
    print("Oh no! Your akk is KAPUT!")
}

myAuto.akkKaput = false

do {
    try myAuto.riding(km: 7)
} catch AutoErrors.belts {
    print("Please, fasten your belts")
} catch AutoErrors.petrol(let km) {
    print("Oh! You had not enough petrol! You wanna to rise \(km) kilometres, but you have only \(myAuto.kmLeft)")
}

myAuto.beltFastened = true

do {
    try myAuto.riding(km: 7)
} catch AutoErrors.belts {
    print("Please, fasten your belts")
} catch AutoErrors.petrol(let km) {
    print("Oh! You had not enough petrol! You wanna to rise \(km) kilometres, but you have only \(myAuto.kmLeft)")
}

do {
    try myAuto.riding(km: 94)
} catch AutoErrors.belts {
    print("Please, fasten your belts")
} catch AutoErrors.petrol(let km) {
    print("Oh! You had not enough petrol! You wanna to ride \(km) kilometres, but you have only \(myAuto.kmLeft)")
}

