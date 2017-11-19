" TODO: auto complete commands
" new join quit
com! -nargs=* Collab py3 Collab.execVimCommand(<f-args>)

function! GetCursorPlace()
    py3 getcursor()
endfunction

if !exists("collab_server")
    let collab_server = '127.0.0.1'
endif

function! CollabStart()
    autocmd CursorMovedI,CursorMoved * py3 Collab.update()
endfunction

py3 << EOF

# I want to keep the dependency as small as possible
import vim
import socket
import msgpack

def getcursor():
    w = vim.current.window
    pos = w.cursor
    print("row: {} col: {}".format(pos[0], pos[1]))

class CollabClient:
    CONN_STATE_NOTCONNECTED = 0
    validCommands = ['new', 'join', 'quit']
    def __init__(self):
        self.connState =  self.CONN_STATE_NOTCONNECTED
        self.name = ""
        self.roomUUID = ""
        self.roomName = ""
        self.active = False
        return None

    def newRoom(self, roomName, username):
        return

    def joinRoom(self):
        return

    def quitRoom():
        return

    def startClient():
        if self.active == True:
            return
        vim.command("CollabStart()")
        self.conn = CollabNetwork()
        self.conn.register()
        self.active = True

    # Currently we don't allow switch to different room
    def execVimCommand(self, *args):
        # Check arguments and validate commands
        if not args or not args[0]:
            self.usage()
            return
        command = args[0]
        if not (command in self.validCommands):
            self.usage()
            return
        if command == "new":
            self.newRoom()
        elif command == "join":
            self.joinRoom()
        else:
            self.quitRoom()
        return

    def update(self):
        return

    def usage(self):
        print(":Collab [new] [join] [quit]")
        

    # Get the default settings from vimrc
    def defaultSettings(self):
        username = vim.eval("collab_username")
        password = vim.eval("collab_password")
        roomUUID = vim.eval("collab_room_uuid")
        if not username:
            self.name = ""
        else:
            self.name = username

        if not roomUUID:
            self.roomUUID = ""
        else:
            self.roomUUID = roomUUID
        return


class CollabNetwork:
    def __init__(self):
        return None

    def register(self):
        self.socket = socket.socket

class CollabProtocol():
    def createPacket(self, msgtype, data):
        data = {
            'msgtype': msgtype,
            'data':data
        }
        raw = msgpack.packb(data)

# only a single instance can exist
Collab = CollabClient()

EOF
