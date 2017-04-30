//===----------------------------------------------------------------------===//
//
// This source file is part of the SwiftNIO open source project
//
// Copyright (c) 2017-2018 Apple Inc. and the SwiftNIO project authors
// Licensed under Apache License v2.0
//
// See LICENSE.txt for license information
// See CONTRIBUTORS.txt for the list of SwiftNIO project authors
//
// SPDX-License-Identifier: Apache-2.0
//
//===----------------------------------------------------------------------===//
import Foundation


public class EchoHandler: ChannelHandler {
    // Write back to the transport
    public func channelRead(ctx: ChannelHandlerContext, data: Buffer) {
        ctx.write(data: data)
    }
    
    // Flush it out. This will use gathering writes for max performance once implemented
    public func channelReadComplete(ctx: ChannelHandlerContext) {
        ctx.flush()
    }
}


try Server.run(host: "0.0.0.0", port: 9999, initPipeline: { pipeline in
    pipeline.addLast(handler: EchoHandler())
})

