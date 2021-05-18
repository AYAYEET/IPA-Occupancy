// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

open class Club: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var clubID_: Property = EntityContainerMetadata.EntityTypes.club.property(withName: "club_ID")

    private static var clubName_: Property = EntityContainerMetadata.EntityTypes.club.property(withName: "clubName")

    private static var currentlyFree_: Property = EntityContainerMetadata.EntityTypes.club.property(withName: "currentlyFree")

    public init(withDefaults: Bool = true, withIndexMap: SparseIndexMap? = nil) {
        super.init(withDefaults: withDefaults, type: EntityContainerMetadata.EntityTypes.club, withIndexMap: withIndexMap)
    }

    open class func array(from: EntityValueList) -> [Club] {
        return ArrayConverter.convert(from.toArray(), [Club]())
    }

    open class var clubID: Property {
        get {
            objc_sync_enter(Club.self)
            defer { objc_sync_exit(Club.self) }
            do {
                return Club.clubID_
            }
        }
        set(value) {
            objc_sync_enter(Club.self)
            defer { objc_sync_exit(Club.self) }
            do {
                Club.clubID_ = value
            }
        }
    }

    open var clubID: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Club.clubID))
        }
        set(value) {
            self.setOptionalValue(for: Club.clubID, to: IntValue.of(optional: value))
        }
    }

    open class var clubName: Property {
        get {
            objc_sync_enter(Club.self)
            defer { objc_sync_exit(Club.self) }
            do {
                return Club.clubName_
            }
        }
        set(value) {
            objc_sync_enter(Club.self)
            defer { objc_sync_exit(Club.self) }
            do {
                Club.clubName_ = value
            }
        }
    }

    open var clubName: String? {
        get {
            return StringValue.optional(self.optionalValue(for: Club.clubName))
        }
        set(value) {
            self.setOptionalValue(for: Club.clubName, to: StringValue.of(optional: value))
        }
    }

    open func copy() -> Club {
        return CastRequired<Club>.from(self.copyEntity())
    }

    open class var currentlyFree: Property {
        get {
            objc_sync_enter(Club.self)
            defer { objc_sync_exit(Club.self) }
            do {
                return Club.currentlyFree_
            }
        }
        set(value) {
            objc_sync_enter(Club.self)
            defer { objc_sync_exit(Club.self) }
            do {
                Club.currentlyFree_ = value
            }
        }
    }

    open var currentlyFree: Int? {
        get {
            return IntValue.optional(self.optionalValue(for: Club.currentlyFree))
        }
        set(value) {
            self.setOptionalValue(for: Club.currentlyFree, to: IntValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(clubID: Int?) -> EntityKey {
        return EntityKey().with(name: "club_ID", value: IntValue.of(optional: clubID))
    }

    open var old: Club {
        return CastRequired<Club>.from(self.oldEntity)
    }
}
