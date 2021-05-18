// # Proxy Compiler 20.3.7-github-20210111

import Foundation
import SAPOData

open class EntityContainer<Provider: DataServiceProvider>: DataService<Provider> {
    public override init(provider: Provider) {
        super.init(provider: provider)
        self.provider.metadata = EntityContainerMetadata.document
    }

    open func fetchClub(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> [Club] {
        let var_query = DataQuery.newIfNull(query: query)
        let var_headers = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options = RequestOptions.noneIfNull(options: options)
        return try Club.array(from: self.executeQuery(var_query.fromDefault(EntityContainerMetadata.EntitySets.club), headers: var_headers, options: var_options).entityList())
    }

    open func fetchClub(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping ([Club]?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result = try self.fetchClub(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchClub1(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Club {
        let var_headers = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options = RequestOptions.noneIfNull(options: options)
        return try CastRequired<Club>.from(self.executeQuery(query.fromDefault(EntityContainerMetadata.EntitySets.club), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchClub1(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Club?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result = try self.fetchClub1(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchClub1WithKey(clubID: Int?, query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> Club {
        let var_query = DataQuery.newIfNull(query: query)
        return try self.fetchClub1(matching: var_query.withKey(Club.key(clubID: clubID)), headers: headers, options: options)
    }

    open func fetchClub1WithKey(clubID: Int?, query: DataQuery?, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (Club?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result = try self.fetchClub1WithKey(clubID: clubID, query: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchUser(matching query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> [User] {
        let var_query = DataQuery.newIfNull(query: query)
        let var_headers = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options = RequestOptions.noneIfNull(options: options)
        return try User.array(from: self.executeQuery(var_query.fromDefault(EntityContainerMetadata.EntitySets.user), headers: var_headers, options: var_options).entityList())
    }

    open func fetchUser(matching query: DataQuery = DataQuery(), headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping ([User]?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result = try self.fetchUser(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchUser1(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> User {
        let var_headers = HTTPHeaders.emptyIfNull(headers: headers)
        let var_options = RequestOptions.noneIfNull(options: options)
        return try CastRequired<User>.from(self.executeQuery(query.fromDefault(EntityContainerMetadata.EntitySets.user), headers: var_headers, options: var_options).requiredEntity())
    }

    open func fetchUser1(matching query: DataQuery, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (User?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result = try self.fetchUser1(matching: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open func fetchUser1WithKey(iUser: String?, query: DataQuery? = nil, headers: HTTPHeaders? = nil, options: RequestOptions? = nil) throws -> User {
        let var_query = DataQuery.newIfNull(query: query)
        return try self.fetchUser1(matching: var_query.withKey(User.key(iUser: iUser)), headers: headers, options: options)
    }

    open func fetchUser1WithKey(iUser: String?, query: DataQuery?, headers: HTTPHeaders? = nil, options: RequestOptions? = nil, completionHandler: @escaping (User?, Error?) -> Void) {
        self.addBackgroundOperationForFunction {
            do {
                let result = try self.fetchUser1WithKey(iUser: iUser, query: query, headers: headers, options: options)
                self.completionQueue.addOperation {
                    completionHandler(result, nil)
                }
            } catch {
                self.completionQueue.addOperation {
                    completionHandler(nil, error)
                }
            }
        }
    }

    open override var metadataLock: MetadataLock {
        return EntityContainerMetadata.lock
    }

    open override func refreshMetadata() throws {
        objc_sync_enter(self)
        defer { objc_sync_exit(self) }
        do {
            try ProxyInternal.refreshMetadataWithLock(service: self, fetcher: nil, options: EntityContainerMetadataParser.options, mergeAction: { EntityContainerMetadataChanges.merge(metadata: self.metadata) })
        }
    }
}
