### Introduction to the Lua Language

Lua is a high-level programming language created to be simple and optimized, at PUCRJ. As its main implementation is written in C, it can be run on a variety of computer systems/architectures without major changes, widely used in embedded systems or devices and games as it does not require many computational resources.

### Roblox Development

Roblox is an online gaming platform that allows its users to create games using the lua language. But, although Roblox Studio is provided (a necessary environment for developing games), the developer needs to create their own frameworks to work with.

When we talk about frameworks in this context, they are sets of modules and scripts that guarantee communication between client and server in a secure and scalable way to perform specific functions.

#### Contextualization

##### Client and Server

Multiplayer online games involve two fundamental sides:

- Client: Takes care of data entry and pre-processing before sending it to the server, such as identifying a skill according to the key pressed or asking the server to create a hitbox area. Any code on the client side can be accessed and changed by exploit programs.

- Server: Ensures consistency between player actions, receives data from the client and performs actions exclusive to the server, i.e. anti-cheat checks, data storage, etc. It cannot be accessed by the client - nor by exploit programs - and communication with the client is carried out through means such as [events remotes](https://create.roblox.com/docs/reference/engine/classes/RemoteEvent) or [remote functions](https://create.roblox.com/docs/reference/engine/classes/RemoteFunction).

##### Important components

There are two ways of communication between server and client:

- ***RemoteEvent***: A remote event allows data transmission between server and client. It is the bridge that communicates local scripts with server scripts securely.
- ***RemoteFunction***: A remote function is capable of returning data from the server to the client and vice versa. Note: For security reasons, it is only used to return data from the server to the client as local scripts can be easily changed via exploit.

##### Directories

Each directory has a function within the development environment. Are they:

- ***StarterCharacterScripts***: Contains local scripts. The server has no access and the scripts are loaded whenever the character is started.
- ***ServerScriptService***: Contains non-local scripts. The client does not have access and the scripts are used to communicate with local scripts.
- ***ReplicatedStorage***: Shared environment between the server side and the client side.
- ***ServerStorage***: Environment where only the server has access.
- ***StarterGui***: Environment for storing ScreenGui objects. Any object of this type will be loaded along with the character.

#### Development Patterns

The Roblox game developer community uses the English language as a standard, whether for communication or for creating and documenting code. Therefore, the codes in this repository will follow this development model for ease of use in forums or team projects.