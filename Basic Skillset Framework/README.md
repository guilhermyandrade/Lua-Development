#### Client Replication

When a visual effect is triggered and played back on the client side, only the client that triggered it can see it. However, if the effect is reproduced on the server side, all clients will be able to see it, but this ends up bringing additional processing loads to the server.

This is where Client Replication comes in, a technique for replicating visual and sound effects in a way that minimizes the workload for the server, increasing player stability, that is, reducing lag.

As in image 1, client 2 identifies that skill This way, the server delegates the processing of effects to clients so that all clients can view them.

##### Image 1 - Visual representation of client replication

<div align="center"><img title="Image 1" src="https://github.com/guilhermyandrade/Lua-Development/blob/main/Basic%20Skillset%20Framework/ClientReplicationImage.png" ></ div>