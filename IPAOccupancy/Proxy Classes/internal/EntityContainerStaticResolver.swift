// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

internal class EntityContainerStaticResolver {
    static func resolve() {
        EntityContainerStaticResolver.resolve1()
    }

    private static func resolve1() {
        Ignore.valueOf_any(EntityContainerMetadata.EntityTypes.club)
        Ignore.valueOf_any(EntityContainerMetadata.EntityTypes.user)
        Ignore.valueOf_any(EntityContainerMetadata.EntitySets.club)
        Ignore.valueOf_any(EntityContainerMetadata.EntitySets.user)
        Ignore.valueOf_any(Club.clubID)
        Ignore.valueOf_any(Club.clubName)
        Ignore.valueOf_any(Club.currentlyFree)
        Ignore.valueOf_any(User.iUser)
        Ignore.valueOf_any(User.password)
        Ignore.valueOf_any(User.status)
        Ignore.valueOf_any(User.prefferedClub)
        Ignore.valueOf_any(User.hasReserved)
        Ignore.valueOf_any(User.reservedClub)
    }
}
