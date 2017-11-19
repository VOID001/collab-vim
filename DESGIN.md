Collabrative Programming Plugin
====

The plugin allow multiple user work on the same piece of code.
And they can see the realtime change, their cursor are in different color

## Usage

Collab register <username>
Collab new <username> <roomName>
Collab join <roomUUID>
Collab quit

## Client

## Server

## Process

* What kind of operation a user provide, move cursor, manipulate text, open different file.
* The first one to start, open a server
* Only the main buffer contain code will be open

## Protocol

### Part1. Realtime network
We need a stable, and long-last connection, so we use TCP long connection
Messages are encoded using msgpack, prepend a length in front, length will be less than 2^16.
The length field doesn't include itself

0            15 ~~~~~~~~~~~~~~~~~~~~~~~~~
----------~~~----------------------------
|  Length    |~~~         Data
----------~~~----------------------------

Data is encoded by msgpack, and can be any of the following type


Client Packet
* update_cursor
* register
* join

Server Packet
* user_connect
* user_leave
* current_buffer

### Part2. 
When a user join the network, they want to see the latest document, instead of a blank doc
The file may be huge, we need to download it to new client's computer, this will go through
File transport protocol





## Client <--> Server

1. [Server] Wating connection ...
2. [Client] Connect to server
  2.1 [Client] Create a new room.
    2.1.1 [Server] Allocate a new room, set a name. And generate a password.
    2.1.2 [Server] Give the room roomTimestamp = 0. To promise the sync between different clients.
    2.1.3 [Server] Set the client as root.
    2.1.4 [Server] Return these information to the client.
    2.1.5 [Client] Join the room as the root member.
  2.2 [Client] Join a room
    2.2.1 [Server] Check the credential. Deny if auth failed.
    2.2.2 [Server] Get the current roomTimestamp.
    2.2.3 [Server] Get the current roomUserList.
    2.2.4 [Server] Return these info to the Client
    2.2.5 [Client] Join the room, with the timestamp = roomTimestamp.
    2.2.6 [Server] Push the room Update info to all clients.
3. [Client] Event thread start. Timer thread start.
4. [Client] Change the current state.
    3.1 [Client] Report the cursor and currentTimestamp
5. [Client] Move cursor / Update content.


## TODOs

[ ] How to know the cursor position.

