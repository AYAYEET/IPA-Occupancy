// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

internal class EntityContainerMetadataParser {
    internal static let options: Int = (CSDLOption.allowCaseConflicts | CSDLOption.disableFacetWarnings | CSDLOption.disableNameValidation | CSDLOption.processMixedVersions | CSDLOption.ignoreUndefinedTerms)

    internal static let parsed: CSDLDocument = xs_immortalize(EntityContainerMetadataParser.parse())

    static func parse() -> CSDLDocument {
        let parser = CSDLParser()
        parser.logWarnings = false
        parser.csdlOptions = EntityContainerMetadataParser.options
        let metadata = parser.parseInProxy(EntityContainerMetadataText.xml, url: "CatalogService")
        metadata.proxyVersion = "20.3.7-github-20210111"
        return metadata
    }
}
