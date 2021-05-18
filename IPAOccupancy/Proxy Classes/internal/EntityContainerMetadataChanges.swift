// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

internal class EntityContainerMetadataChanges {
    static func merge(metadata: CSDLDocument) {
        metadata.hasGeneratedProxies = true
        EntityContainerMetadata.document = metadata
        EntityContainerMetadataChanges.merge1(metadata: metadata)
        try! EntityContainerFactory.registerAll()
    }

    private static func merge1(metadata: CSDLDocument) {
        Ignore.valueOf_any(metadata)
        if !EntityContainerMetadata.EntityTypes.club.isRemoved {
            EntityContainerMetadata.EntityTypes.club = metadata.entityType(withName: "CatalogService.Club")
        }
        if !EntityContainerMetadata.EntityTypes.user.isRemoved {
            EntityContainerMetadata.EntityTypes.user = metadata.entityType(withName: "CatalogService.User")
        }
        if !EntityContainerMetadata.EntitySets.club.isRemoved {
            EntityContainerMetadata.EntitySets.club = metadata.entitySet(withName: "Club")
        }
        if !EntityContainerMetadata.EntitySets.user.isRemoved {
            EntityContainerMetadata.EntitySets.user = metadata.entitySet(withName: "User")
        }
        if !Club.clubID.isRemoved {
            Club.clubID = EntityContainerMetadata.EntityTypes.club.property(withName: "club_ID")
        }
        if !Club.clubName.isRemoved {
            Club.clubName = EntityContainerMetadata.EntityTypes.club.property(withName: "clubName")
        }
        if !Club.currentlyFree.isRemoved {
            Club.currentlyFree = EntityContainerMetadata.EntityTypes.club.property(withName: "currentlyFree")
        }
        if !User.iUser.isRemoved {
            User.iUser = EntityContainerMetadata.EntityTypes.user.property(withName: "i_User")
        }
        if !User.password.isRemoved {
            User.password = EntityContainerMetadata.EntityTypes.user.property(withName: "password")
        }
        if !User.status.isRemoved {
            User.status = EntityContainerMetadata.EntityTypes.user.property(withName: "status")
        }
        if !User.prefferedClub.isRemoved {
            User.prefferedClub = EntityContainerMetadata.EntityTypes.user.property(withName: "prefferedClub")
        }
        if !User.hasReserved.isRemoved {
            User.hasReserved = EntityContainerMetadata.EntityTypes.user.property(withName: "hasReserved")
        }
        if !User.reservedClub.isRemoved {
            User.reservedClub = EntityContainerMetadata.EntityTypes.user.property(withName: "reservedClub")
        }
    }
}
