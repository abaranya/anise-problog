__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

import sys
from fileparsing.abfile import ABPropFile
from fileparsing.inputproc import InputProc

def main(argv):
    # todo: process some input parameters
    inputproc = InputProc('Parse Problog Output for centerline calculations')

    inputproc.printhelp()

    args = inputproc.parse(argv)

    print(args.cfgfile[0].name)

    someobject = ABPropFile(args.cfgfile[0].name)

    print(someobject.filename)

# todo: do something with the input

# todo: give some output
    return

if __name__ == "__main__":
    main(sys.argv[1:])
