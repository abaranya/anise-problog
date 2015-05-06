__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

import sys
from fileparsing import abutil
from fileparsing.abfile import ABPropFile
from fileparsing.inputproc import InputProc


def read_file_by_cfg(input_file, cfg_file):
    """read input file using cfg definition"""
    input_definition = ABPropFile(cfg_file)

    return []  # todo: update to proper return value


def main(argv):

    # todo: parse some input parameters
    inputproc = InputProc('Parse Problog Output for centerline calculations')
    parsed_args = inputproc.parse(argv)

    abutil.debug(parsed_args.cfgfile[0].name)

    # todo: do something with the input
    records = read_file_by_cfg(parsed_args.inputfile[0], parsed_args.cfgfile[0])

    # todo: give some output

    abutil.debug(records)

    return

if __name__ == "__main__":
    main(sys.argv[1:])
