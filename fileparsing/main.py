__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

import sys
from fileparsing import abutil
from fileparsing.abfile import ABPropFile
from fileparsing.inputproc import InputProc


def read_file_by_cfg(input_file, cfg_file):
    """read input file using cfg definition"""

    #  process configuration file definition
    property_file = ABPropFile(cfg_file)

    if not property_file.parse():
        return None

    # get the record spec
    record_definition = property_file.get_record_definition()

    # todo: add file processing using record definition

    return record_definition  # todo: check this


def main(argv):

    # parse some input parameters
    inputproc = InputProc('Parse Problog Output for centerline calculations')
    parsed_args = inputproc.parse(argv)

    abutil.debug(parsed_args.cfgfile[0].name)

    # read input file based on
    records = read_file_by_cfg(parsed_args.inputfile[0], parsed_args.cfgfile[0])

    # todo: give some output

    abutil.debug(records)

    return

if __name__ == "__main__":
    main(sys.argv[1:])
