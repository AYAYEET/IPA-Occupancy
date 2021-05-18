// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

open class User: EntityValue {
    public required init(from decoder: Decoder) throws {
        try super.init(from: decoder)
    }

    private static var iUser_: Property = EntityContainerMetadata.EntityTypes.user.property(withName: "i_User")

    private static var password_: Property = EntityContainerMetadata.EntityTypes.user.property(withName: "password")

    private static var status_: Property = EntityContainerMetadata.EntityTypes.user.property(withName: "status")

    private static var prefferedClub_: Property = EntityContainerMetadata.EntityTypes.user.property(withName: "prefferedClub")

    private static var hasReserved_: Property = EntityContainerMetadata.EntityTypes.user.property(withName: "hasReserved")

    private static var reservedClub_: Property = EntityContainerMetadata.EntityTypes.user.property(withName: "reservedClub")

    public init(withDefaults: Bool = true, withIndexMap: SparseIndexMap? = nil) {
        super.init(withDefaults: withDefaults, type: EntityContainerMetadata.EntityTypes.user, withIndexMap: withIndexMap)
    }

    open class func array(from: EntityValueList) -> [User] {
        return ArrayConverter.convert(from.toArray(), [User]())
    }

    open func copy() -> User {
        return CastRequired<User>.from(self.copyEntity())
    }

    open class var hasReserved: Property {
        get {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                return User.hasReserved_
            }
        }
        set(value) {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                User.hasReserved_ = value
            }
        }
    }

    open var hasReserved: Bool? {
        get {
            return BooleanValue.optional(self.optionalValue(for: User.hasReserved))
        }
        set(value) {
            self.setOptionalValue(for: User.hasReserved, to: BooleanValue.of(optional: value))
        }
    }

    open class var iUser: Property {
        get {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                return User.iUser_
            }
        }
        set(value) {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                User.iUser_ = value
            }
        }
    }

    open var iUser: String? {
        get {
            return StringValue.optional(self.optionalValue(for: User.iUser))
        }
        set(value) {
            self.setOptionalValue(for: User.iUser, to: StringValue.of(optional: value))
        }
    }

    open override var isProxy: Bool {
        return true
    }

    open class func key(iUser: String?) -> EntityKey {
        return EntityKey().with(name: "i_User", value: StringValue.of(optional: iUser))
    }

    open var old: User {
        return CastRequired<User>.from(self.oldEntity)
    }

    open class var password: Property {
        get {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                return User.password_
            }
        }
        set(value) {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                User.password_ = value
            }
        }
    }

    open var password: String? {
        get {
            return StringValue.optional(self.optionalValue(for: User.password))
        }
        set(value) {
            self.setOptionalValue(for: User.password, to: StringValue.of(optional: value))
        }
    }

    open class var prefferedClub: Property {
        get {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                return User.prefferedClub_
            }
        }
        set(value) {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                User.prefferedClub_ = value
            }
        }
    }

    open var prefferedClub: String? {
        get {
            return StringValue.optional(self.optionalValue(for: User.prefferedClub))
        }
        set(value) {
            self.setOptionalValue(for: User.prefferedClub, to: StringValue.of(optional: value))
        }
    }

    open class var reservedClub: Property {
        get {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                return User.reservedClub_
            }
        }
        set(value) {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                User.reservedClub_ = value
            }
        }
    }

    open var reservedClub: String? {
        get {
            return StringValue.optional(self.optionalValue(for: User.reservedClub))
        }
        set(value) {
            self.setOptionalValue(for: User.reservedClub, to: StringValue.of(optional: value))
        }
    }

    open class var status: Property {
        get {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                return User.status_
            }
        }
        set(value) {
            objc_sync_enter(User.self)
            defer { objc_sync_exit(User.self) }
            do {
                User.status_ = value
            }
        }
    }

    open var status: String? {
        get {
            return StringValue.optional(self.optionalValue(for: User.status))
        }
        set(value) {
            self.setOptionalValue(for: User.status, to: StringValue.of(optional: value))
        }
    }
}
