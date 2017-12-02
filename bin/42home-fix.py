#!/usr/bin/env python3
# Since the staff take forever to fix bugs let's fix it ourselves

import shutil
import sys
import os
from pathlib import Path

# On my session "~/Library/Application Support" isn't a symlink as it should and this file can't be replaced; why not link it's subfolders then!
def fix_library():
    p = Path("~/Library/Application Support").expanduser()
    dirs = [x for x in p.iterdir() if x.is_dir() and not x.is_symlink() and x.suffix != ".bak"]

    for dir in dirs:
        link = Path("/Volumes/Storage/cache/bwaegene/Library/Application Support/" + dir.name)
        link.mkdir(parents=True, exist_ok=True)
        shutil.rmtree(dir.as_posix())
        dir.symlink_to(link)

# Someone thought they will help emacs users by recreating the ~/.emacs if absent during the login... Let's revert that folly.
def fix_dotemacs():
    dotemacs = Path("~/.emacs").expanduser()
    if dotemacs.exists():
        print(dotemacs)
        os.remove(dotemacs.as_posix())

def main ():
    fix_library()
    fix_dotemacs()

if __name__ == "__main__":
    main()
