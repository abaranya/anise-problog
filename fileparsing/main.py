__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

from collections import defaultdict
import sys
from fileparsing import abutil
from fileparsing.abfile import ABPropFile
from fileparsing.inputproc import InputProc
from fileparsing.probfile import ProbFile


def read_file_by_cfg(input_file, cfg_file):
    """read input file using cfg definition"""

    #  process configuration file definition
    property_file = ABPropFile(cfg_file)

    # get the record spec
    (header_definition, record_definition) = property_file.parse()

    # parse the file using definition
    # and get the probabilities
    prob_file = ProbFile(record_definition)
    prob_file.set_file(input_file)
    probabilities = prob_file.read_file()

    return probabilities  # todo: check this

def group_by_z(probs):
    # group the records by Z
    listing = defaultdict(list)

    for voxel in probs:
        key = int(voxel['Z'])
        # prob = {'prob': float(voxel['prob']), 'voxel': voxel}
        prob = float(voxel['prob'])
        value = {'voxel': voxel}
        listing[key].append((prob, value))

    return listing


def find_best_route(probs, k=3):
    """use find higger k per slide """
    if k < 1:
        return []

    listing = group_by_z(probs)
    route = {}

    # select the top k from each Z
    for slice_value in listing:
        #  get the slice
        slice_cut = listing[slice_value]
        sorted_slice = sorted(slice_cut, key=lambda slice_cut: slice_cut[0],
                              reverse=True)

        route[slice_value] = sorted_slice[0:k]

    return route

def main(argv):

    # parse some input parameters
    inputproc = InputProc('Parse Problog Output for centerline calculations')
    parsed_args = inputproc.parse(argv)

    abutil.debug(parsed_args.cfgfile[0].name)

    # read input file based on cfg dfinition
    probs = read_file_by_cfg(parsed_args.inputfile[0], parsed_args.cfgfile[0])
    abutil.debug(probs)

    # process the result set
    route = find_best_route(probs)
    abutil.debug(route)

    #  todo: do some fancy print out & return

    return

if __name__ == "__main__":
    main(sys.argv[1:])
