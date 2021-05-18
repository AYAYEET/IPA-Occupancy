// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

internal class EntityContainerFactory {
    static func registerAll() throws {
        EntityContainerMetadata.EntityTypes.club.registerFactory(ObjectFactory.with(create: { Club(withDefaults: false) }, sparse: { m in Club(withDefaults: false, withIndexMap: m) }, decode: { d in try Club(from: d) }))
        EntityContainerMetadata.EntityTypes.user.registerFactory(ObjectFactory.with(create: { User(withDefaults: false) }, sparse: { m in User(withDefaults: false, withIndexMap: m) }, decode: { d in try User(from: d) }))
        EntityContainerStaticResolver.resolve()
    }
}
