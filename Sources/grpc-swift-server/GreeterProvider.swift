//
//  GreeterProvider.swift
//  grpc-swift-server
//
//  Created by 梁煜麟 on 5/27/20.
//

import GRPC
import NIO

class GreeterProvider2: Helloworld_GreeterProvider {
  func sayHello(
    request: Helloworld_HelloRequest,
    context: StatusOnlyCallContext
  ) -> EventLoopFuture<Helloworld_HelloReply> {
    let recipient = request.name.isEmpty ? "stranger" : request.name
    let response = Helloworld_HelloReply.with {
      $0.message = "Hello \(recipient)!"
    }
    return context.eventLoop.makeSucceededFuture(response)
  }
}

class GreeterProvider : Greet_GreetingServiceProvider {
    func greet(
        request: Greet_GreetRequest,
        context: StatusOnlyCallContext
    ) -> EventLoopFuture<Greet_GreetResponse> {
        let firstName = request.greeting.firstName;
        let lastName = request.greeting.lastName;
        let response = Greet_GreetResponse.with {
            $0.result = "Hello \(firstName) \(lastName), welcome to swift server world!"
        }
        return context.eventLoop.makeSucceededFuture(response)
    }
}
