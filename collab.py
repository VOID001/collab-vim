import vim


def getcursor():
    w = vim.current.window
    pos = w.cursor()
    print(pos)
