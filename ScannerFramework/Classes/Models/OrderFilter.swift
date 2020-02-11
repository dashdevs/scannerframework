//
//  OrderFilter.swift
//  GoodsScanner
//
//  Created by Alexander Kozlov on 9/2/19.
//  Copyright © 2019 iTomych. All rights reserved.
//

import Foundation

public class DateRangeFilter {
    private lazy var formatter = DateFormatter.dottedYearMonthDayFormatter
    
    public var fromDate: Date {
        didSet {
            fromDate = fromDate.startOfDay
        }
    }
    public var beforeDate: Date {
        didSet {
            beforeDate = beforeDate.endOfDay
        }
    }
    
    public var formattedFromDate: String {
        return formatter.string(from: fromDate)
    }
    
    public var formattedBeforeDate: String {
        return formatter.string(from: beforeDate)
    }
    
    public var queryItems: [URLQueryItem] {
        return [URLQueryItem(name: "FromDate", value: String(Int64(fromDate.timeIntervalSince1970))),
                URLQueryItem(name: "BeforeDate", value: String(Int64(beforeDate.timeIntervalSince1970)))]
    }
    
    public init(fromDate: Date = Date.yesterday, beforeDate: Date = Date()) {
        self.fromDate = fromDate.startOfDay
        self.beforeDate = beforeDate.endOfDay
    }
}

public class SelectableOrderFilter {
    public var storages: [StorageModel]?
    public var dateRange: DateRangeFilter
    
    init(fromRange: DateRangeFilter = DateRangeFilter(), storages: [StorageModel]? = nil) {
        self.storages = storages
        dateRange = fromRange
    }
    
    public var storageNames: String {
        guard let storages = storages, !storages.isEmpty else { return L10n.allTitle }
        return storages.map { $0.name }.joined(separator: ", ")
    }
}

public class OrderFilter: SelectableOrderFilter {
    private let type: OrderType
    public var state: OrderState?
    public var search: String?
    
    public init(type: OrderType = .inventory, state: OrderState? = nil) {
        self.type = type
        self.state = state
        super.init()
    }
    
    var queryItems: [URLQueryItem] {
        var queryItems = dateRange.queryItems
        queryItems.append(URLQueryItem(name: "Types", value: type.rawValue))
        if let stateQueryItem = state?.queryItem {
            queryItems.append(stateQueryItem)
        }
        storages?.forEach { queryItems.append(URLQueryItem(name: "Storages", value: String($0.id))) }
        search.flatMap { queryItems.append(URLQueryItem(name: "Search", value: $0)) }        
        return queryItems
    }
    
    public var selectableFilters: SelectableOrderFilter {
        get {
            return SelectableOrderFilter(fromRange: dateRange, storages: storages)
        }
        
        set {
            dateRange = newValue.dateRange
            storages = newValue.storages
        }
    }
    
    public var filterTillToday: OrderFilter {
        let filter = OrderFilter(type: type, state: state)
        filter.search = search
        filter.selectableFilters.storages = selectableFilters.storages
        filter.selectableFilters.dateRange.fromDate = Date(timeIntervalSince1970: 0)
        return filter
    }
}
