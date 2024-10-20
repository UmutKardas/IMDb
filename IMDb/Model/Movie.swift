//
//  Movie.swift
//  IMDb
//
//  Created by Hüseyin Umut Kardaş on 15.10.2024.
//

import Foundation

// MARK: - Movie

struct Movie: Codable {
    let status: Bool?
    let message: String?
    let timestamp: Int?
    let data: [Datum]?
}

// MARK: - Datum

struct Datum: Codable {
    let id: String?
    let isAdult: Bool?
    let canRateTitle: CanRateTitle?
    let originalTitleText: OriginalTitleText?
    let primaryImage: PrimaryImage?
    let ratingsSummary: RatingsSummary?
    let releaseYear: ReleaseYear?
    let titleEpisode: JSONNull?
    let titleText: OriginalTitleText?
    let titleType: TitleType?
    let series: JSONNull?
    let watchOptionsByCategory: WatchOptionsByCategory?
    let plot: Plot?
    let releaseDate: ReleaseDate?
    let titleCertificate: TitleCertificate?
    let titleRuntime: TitleRuntime?
    let chartMeterRanking: ChartMeterRanking?
}

// MARK: - CanRateTitle

struct CanRateTitle: Codable {
    let isRatable: Bool?
}

// MARK: - ChartMeterRanking

struct ChartMeterRanking: Codable {
    let currentRank: Int?
    let rankChange: RankChange?
}

// MARK: - RankChange

struct RankChange: Codable {
    let changeDirection: ChangeDirection?
    let difference: Int?
}

enum ChangeDirection: String, Codable {
    case down = "DOWN"
    case flat = "FLAT"
    case up = "UP"
}

// MARK: - OriginalTitleText

struct OriginalTitleText: Codable {
    let text: String?
}

// MARK: - Plot

struct Plot: Codable {
    let id: String?
    let author: JSONNull?
    let plotText: PlotText?
    let correctionLink, reportingLink: Link?
}

// MARK: - Link

struct Link: Codable {
    let url: String?
}

// MARK: - PlotText

struct PlotText: Codable {
    let plainText: String?
}

// MARK: - PrimaryImage

struct PrimaryImage: Codable {
    let id: String?
    let imageURL: String?
    let imageWidth, imageHeight: Int?

    enum CodingKeys: String, CodingKey {
        case id
        case imageURL = "imageUrl"
        case imageWidth, imageHeight
    }
}

// MARK: - RatingsSummary

struct RatingsSummary: Codable {
    let aggregateRating: Double?
    let topRanking: TopRanking?
    let voteCount: Int?
}

// MARK: - TopRanking

struct TopRanking: Codable {
    let rank: Int?
}

// MARK: - ReleaseDate

struct ReleaseDate: Codable {
    let day, month, year: Int?
    let country: Country?
    let restriction: JSONNull?
    let releaseAttributes: [OriginalTitleText]?
}

// MARK: - Country

struct Country: Codable {
    let id: CountryID?
    let text: CountryText?
}

enum CountryID: String, Codable {
    case us = "US"
}

enum CountryText: String, Codable {
    case unitedStates = "United States"
}

// MARK: - ReleaseYear

struct ReleaseYear: Codable {
    let year: Int?
    let endYear: Int?
}

// MARK: - TitleCertificate

struct TitleCertificate: Codable {
    let rating: String?
    let certificateCountry: Country?
    let ratingReason: String?
}

// MARK: - TitleRuntime

struct TitleRuntime: Codable {
    let seconds: Int?
    let displayableProperty: TitleRuntimeDisplayableProperty?
}

// MARK: - TitleRuntimeDisplayableProperty

struct TitleRuntimeDisplayableProperty: Codable {
    let qualifiersInMarkdownList: JSONNull?
}

// MARK: - TitleType

struct TitleType: Codable {
    let id: TitleTypeID?
    let text: TitleTypeText?
    let displayableProperty: TitleTypeDisplayableProperty?
    let categories: [Category]?
    let canHaveEpisodes, isSeries, isEpisode: Bool?
}

// MARK: - Category

struct Category: Codable {
    let id: ValueEnum?
    let text: CategoryText?
    let value: ValueEnum?
}

enum ValueEnum: String, Codable {
    case movie
    case tv
}

enum CategoryText: String, Codable {
    case movie = "Movie"
    case tv = "TV"
}

// MARK: - TitleTypeDisplayableProperty

struct TitleTypeDisplayableProperty: Codable {
    let value: PlotText?
}

enum TitleTypeID: String, Codable {
    case movie
    case tvMiniSeries
    case tvSeries
}

enum TitleTypeText: String, Codable {
    case movie = "Movie"
    case tvMiniSeries = "TV Mini Series"
    case tvSeries = "TV Series"
}

// MARK: - WatchOptionsByCategory

struct WatchOptionsByCategory: Codable {
    let categorizedWatchOptionsList: [CategorizedWatchOptionsList]?
}

// MARK: - CategorizedWatchOptionsList

struct CategorizedWatchOptionsList: Codable {
    let watchOptions: [WatchOption]?
}

// MARK: - WatchOption

struct WatchOption: Codable {
    let provider: Provider?
    let title, description: Description?
    let shortDescription: Description?
    let link: String?
}

// MARK: - Description

struct Description: Codable {
    let value: String?
}

// MARK: - Provider

struct Provider: Codable {
    let id: String?
    let categoryType: CategoryType?
    let description: Description?
    let name: Description?
    let refTagFragment: String?
    let logos: Logos?
}

enum CategoryType: String, Codable {
    case rentOrBuy = "RENT_OR_BUY"
    case subscription = "SUBSCRIPTION"
}

// MARK: - Logos

struct Logos: Codable {
    let icon, slate: Icon?
}

// MARK: - Icon

struct Icon: Codable {
    let url: String?
    let width, height: Int?
}

// MARK: - Encode/decode helpers

class JSONNull: Codable, Hashable {
    public static func == (lhs: JSONNull, rhs: JSONNull) -> Bool {
        return true
    }

    public var hashValue: Int {
        return 0
    }

    public init() {}

    public required init(from decoder: Decoder) throws {
        let container = try decoder.singleValueContainer()
        if !container.decodeNil() {
            throw DecodingError.typeMismatch(JSONNull.self, DecodingError.Context(codingPath: decoder.codingPath, debugDescription: "Wrong type for JSONNull"))
        }
    }

    public func encode(to encoder: Encoder) throws {
        var container = encoder.singleValueContainer()
        try container.encodeNil()
    }
}
