//

import Foundation
import Combine
import Apollo

@available(iOS 13, *)
public final class GraphQLMutationSubscription<GraphMutation: GraphQLMutation, SubscriberType: Subscriber>: Subscription
where SubscriberType.Input == GraphQLResult<GraphMutation.Data>, SubscriberType.Failure == Error {

    private let subscriber: SubscriberType
    private var cancellable: Apollo.Cancellable? = nil

    init(client: ApolloClient,
         mutation: GraphMutation,
         subscriber: SubscriberType) {

        self.subscriber = subscriber
        self.cancellable = client.perform(mutation: mutation,
                                        resultHandler: self.handle)
    }

    deinit {
        cancellable?.cancel()
    }

    public func request(_ demand: Subscribers.Demand) { }

    public func cancel() {
        cancellable?.cancel()
        cancellable = nil
    }

    public func handle(result: Result<GraphQLResult<GraphMutation.Data>, Error>) {
        switch result {
            case .success(let resultSet):
                _ = subscriber.receive(resultSet)
            case .failure(let e):
                subscriber.receive(completion: .failure(e))
        }
        subscriber.receive(completion: .finished)
    }
}
