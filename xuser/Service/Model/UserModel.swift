//
//
//  xuser
//
//  Created by Hasan Saral on 2.07.2025.
//


import Foundation
import SwiftData

@Model
class User: Codable {
    var id: Int
    var name: String
    var username: String
    var email: String
    var phone: String
    var website: String
    var address: Address
    var company: Company

    enum CodingKeys: CodingKey {
        case id, name, username, email, phone, website, address, company
    }

    init(id: Int, name: String, username: String, email: String, phone: String, website: String, address: Address, company: Company) {
        self.id = id
        self.name = name
        self.username = username
        self.email = email
        self.phone = phone
        self.website = website
        self.address = address
        self.company = company
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let address = try container.decode(Address.self, forKey: .address)
        let company = try container.decode(Company.self, forKey: .company)

        self.init(
            id: try container.decode(Int.self, forKey: .id),
            name: try container.decode(String.self, forKey: .name),
            username: try container.decode(String.self, forKey: .username),
            email: try container.decode(String.self, forKey: .email),
            phone: try container.decode(String.self, forKey: .phone),
            website: try container.decode(String.self, forKey: .website),
            address: address,
            company: company
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(id, forKey: .id)
        try container.encode(name, forKey: .name)
        try container.encode(username, forKey: .username)
        try container.encode(email, forKey: .email)
        try container.encode(phone, forKey: .phone)
        try container.encode(website, forKey: .website)
        try container.encode(address, forKey: .address)
        try container.encode(company, forKey: .company)
    }
}

@Model
class Address: Codable {
    var street: String
    var suite: String
    var city: String
    var zipcode: String
    var geo: Geo

    enum CodingKeys: CodingKey {
        case street, suite, city, zipcode, geo
    }

    init(street: String, suite: String, city: String, zipcode: String, geo: Geo) {
        self.street = street
        self.suite = suite
        self.city = city
        self.zipcode = zipcode
        self.geo = geo
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        let geo = try container.decode(Geo.self, forKey: .geo)

        self.init(
            street: try container.decode(String.self, forKey: .street),
            suite: try container.decode(String.self, forKey: .suite),
            city: try container.decode(String.self, forKey: .city),
            zipcode: try container.decode(String.self, forKey: .zipcode),
            geo: geo
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(street, forKey: .street)
        try container.encode(suite, forKey: .suite)
        try container.encode(city, forKey: .city)
        try container.encode(zipcode, forKey: .zipcode)
        try container.encode(geo, forKey: .geo)
    }
}

@Model
class Geo: Codable {
    var lat: String
    var lng: String

    enum CodingKeys: CodingKey {
        case lat, lng
    }

    init(lat: String, lng: String) {
        self.lat = lat
        self.lng = lng
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            lat: try container.decode(String.self, forKey: .lat),
            lng: try container.decode(String.self, forKey: .lng)
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(lat, forKey: .lat)
        try container.encode(lng, forKey: .lng)
    }
}

@Model
class Company: Codable {
    var name: String
    var catchPhrase: String
    var bs: String

    enum CodingKeys: CodingKey {
        case name, catchPhrase, bs
    }

    init(name: String, catchPhrase: String, bs: String) {
        self.name = name
        self.catchPhrase = catchPhrase
        self.bs = bs
    }

    required convenience init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        self.init(
            name: try container.decode(String.self, forKey: .name),
            catchPhrase: try container.decode(String.self, forKey: .catchPhrase),
            bs: try container.decode(String.self, forKey: .bs)
        )
    }

    func encode(to encoder: Encoder) throws {
        var container = encoder.container(keyedBy: CodingKeys.self)
        try container.encode(name, forKey: .name)
        try container.encode(catchPhrase, forKey: .catchPhrase)
        try container.encode(bs, forKey: .bs)
    }
}

typealias XuserModel = [User]
