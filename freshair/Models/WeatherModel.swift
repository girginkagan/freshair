import Foundation

class WeatherModel: Codable {
    let cod: String
    let message: Double
    let cnt: Int
    let list: [WeatherList]
    let city: City
    
    init(cod: String, message: Double, cnt: Int, list: [WeatherList], city: City) {
        self.cod = cod
        self.message = message
        self.cnt = cnt
        self.list = list
        self.city = city
    }
}

class City: Codable {
    let id: Int
    let name: String
    let coord: Coord
    let country: String
    let population: Int
    
    init(id: Int, name: String, coord: Coord, country: String, population: Int) {
        self.id = id
        self.name = name
        self.coord = coord
        self.country = country
        self.population = population
    }
}

class Coord: Codable {
    let lat, lon: Double
    
    init(lat: Double, lon: Double) {
        self.lat = lat
        self.lon = lon
    }
}

class WeatherList: Codable {
    let dt: Int
    let main: MainClass
    let weather: [Weather]
    let clouds: Clouds
    let wind: Wind
    let sys: Sys
    let dtTxt: String
    let rain: Rain?
    
    enum CodingKeys: String, CodingKey {
        case dt, main, weather, clouds, wind, sys
        case dtTxt = "dt_txt"
        case rain
    }
    
    init(dt: Int, main: MainClass, weather: [Weather], clouds: Clouds, wind: Wind, sys: Sys, dtTxt: String, rain: Rain?) {
        self.dt = dt
        self.main = main
        self.weather = weather
        self.clouds = clouds
        self.wind = wind
        self.sys = sys
        self.dtTxt = dtTxt
        self.rain = rain
    }
}

class Clouds: Codable {
    let all: Int
    
    init(all: Int) {
        self.all = all
    }
}

class MainClass: Codable {
    let temp, tempMin, tempMax, pressure: Double
    let seaLevel, grndLevel: Double
    let humidity: Int
    let tempKf: Double
    
    enum CodingKeys: String, CodingKey {
        case temp
        case tempMin = "temp_min"
        case tempMax = "temp_max"
        case pressure
        case seaLevel = "sea_level"
        case grndLevel = "grnd_level"
        case humidity
        case tempKf = "temp_kf"
    }
    
    init(temp: Double, tempMin: Double, tempMax: Double, pressure: Double, seaLevel: Double, grndLevel: Double, humidity: Int, tempKf: Double) {
        self.temp = temp
        self.tempMin = tempMin
        self.tempMax = tempMax
        self.pressure = pressure
        self.seaLevel = seaLevel
        self.grndLevel = grndLevel
        self.humidity = humidity
        self.tempKf = tempKf
    }
}

class Rain: Codable {
    let the3H: Double?
    
    enum CodingKeys: String, CodingKey {
        case the3H = "3h"
    }
    
    init(the3H: Double?) {
        self.the3H = the3H
    }
}

class Sys: Codable {
    let pod: Pod
    
    init(pod: Pod) {
        self.pod = pod
    }
}

enum Pod: String, Codable {
    case d = "d"
    case n = "n"
}

class Weather: Codable {
    let id: Int
    let main: String
    let description, icon: String
    
    init(id: Int, main: String, description: String, icon: String) {
        self.id = id
        self.main = main
        self.description = description
        self.icon = icon
    }
}

class Wind: Codable {
    let speed, deg: Double
    
    init(speed: Double, deg: Double) {
        self.speed = speed
        self.deg = deg
    }
}
