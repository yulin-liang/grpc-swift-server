import GRPC
import NIO
import Logging

// Quieten the logs.
LoggingSystem.bootstrap {
  var handler = StreamLogHandler.standardOutput(label: $0)
  handler.logLevel = .critical
  return handler
}

let group = MultiThreadedEventLoopGroup(numberOfThreads: 1)
defer {
  try! group.syncShutdownGracefully()
}

// Create some configuration for the server:
let configuration = Server.Configuration(
  target: .hostAndPort("localhost", 50051),
  eventLoopGroup: group,
  serviceProviders: [GreeterProvider()]
)

// Start the server and print its address once it has started.
let server = Server.start(configuration: configuration)
server.map {
  $0.channel.localAddress
}.whenSuccess { address in
  print("server started on port \(address!.port!)")
}

// Wait on the server's `onClose` future to stop the program from exiting.
_ = try server.flatMap {
  $0.onClose
}.wait()
