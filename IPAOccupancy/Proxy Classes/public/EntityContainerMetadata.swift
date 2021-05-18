// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

public class EntityContainerMetadata {
    private static var document_: CSDLDocument = EntityContainerMetadata.resolve()

    public static let lock: MetadataLock = xs_immortalize(MetadataLock())

    public static var document: CSDLDocument {
        get {
            objc_sync_enter(EntityContainerMetadata.self)
            defer { objc_sync_exit(EntityContainerMetadata.self) }
            do {
                return EntityContainerMetadata.document_
            }
        }
        set(value) {
            objc_sync_enter(EntityContainerMetadata.self)
            defer { objc_sync_exit(EntityContainerMetadata.self) }
            do {
                EntityContainerMetadata.document_ = value
            }
        }
    }

    private static func resolve() -> CSDLDocument {
        try! EntityContainerFactory.registerAll()
        EntityContainerMetadataParser.parsed.hasGeneratedProxies = true
        return EntityContainerMetadataParser.parsed.immortalize()
    }

    public class EntityTypes {
        private static var club_: EntityType = EntityContainerMetadataParser.parsed.entityType(withName: "CatalogService.Club")

        private static var user_: EntityType = EntityContainerMetadataParser.parsed.entityType(withName: "CatalogService.User")

        public static var club: EntityType {
            get {
                objc_sync_enter(EntityContainerMetadata.EntityTypes.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntityTypes.self) }
                do {
                    return EntityContainerMetadata.EntityTypes.club_
                }
            }
            set(value) {
                objc_sync_enter(EntityContainerMetadata.EntityTypes.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntityTypes.self) }
                do {
                    EntityContainerMetadata.EntityTypes.club_ = value
                }
            }
        }

        public static var user: EntityType {
            get {
                objc_sync_enter(EntityContainerMetadata.EntityTypes.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntityTypes.self) }
                do {
                    return EntityContainerMetadata.EntityTypes.user_
                }
            }
            set(value) {
                objc_sync_enter(EntityContainerMetadata.EntityTypes.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntityTypes.self) }
                do {
                    EntityContainerMetadata.EntityTypes.user_ = value
                }
            }
        }
    }

    public class EntitySets {
        private static var club_: EntitySet = EntityContainerMetadataParser.parsed.entitySet(withName: "Club")

        private static var user_: EntitySet = EntityContainerMetadataParser.parsed.entitySet(withName: "User")

        public static var club: EntitySet {
            get {
                objc_sync_enter(EntityContainerMetadata.EntitySets.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntitySets.self) }
                do {
                    return EntityContainerMetadata.EntitySets.club_
                }
            }
            set(value) {
                objc_sync_enter(EntityContainerMetadata.EntitySets.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntitySets.self) }
                do {
                    EntityContainerMetadata.EntitySets.club_ = value
                }
            }
        }

        public static var user: EntitySet {
            get {
                objc_sync_enter(EntityContainerMetadata.EntitySets.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntitySets.self) }
                do {
                    return EntityContainerMetadata.EntitySets.user_
                }
            }
            set(value) {
                objc_sync_enter(EntityContainerMetadata.EntitySets.self)
                defer { objc_sync_exit(EntityContainerMetadata.EntitySets.self) }
                do {
                    EntityContainerMetadata.EntitySets.user_ = value
                }
            }
        }
    }
}
