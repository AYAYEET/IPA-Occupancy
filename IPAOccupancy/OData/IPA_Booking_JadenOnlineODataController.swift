//
// IPAOccupancy
//
// Created by SAP Cloud Platform SDK for iOS Assistant application on 18/05/21
//

import Foundation
import SAPCommon
import SAPFiori
import SAPFioriFlows
import SAPFoundation
import SAPOData

public class IPA_Booking_JadenOnlineODataController: ODataControlling {
    private let logger = Logger.shared(named: "IPA_Booking_JadenOnlineODataController")
    var entityContainer: EntityContainer<OnlineODataProvider>!

    public init() {}

    // MARK: - Public methods

    // Read more about consumption of OData services in mobile applications: https://help.sap.com/viewer/fc1a59c210d848babfb3f758a6f55cb1/Latest/en-US/22e9533533c646d8831e87357519cf4e.html
    public func configureOData(sapURLSession: SAPURLSession, serviceRoot: URL) throws {
        let odataProvider = OnlineODataProvider(serviceName: "EntityContainer", serviceRoot: serviceRoot, sapURLSession: sapURLSession)
        // Disables version validation of the backend OData service
        odataProvider.serviceOptions.checkVersion = false
        self.entityContainer = EntityContainer(provider: odataProvider)
        // To update entity force to use X-HTTP-Method header
        self.entityContainer.provider.networkOptions.tunneledMethods.append("MERGE")
    }
}
