__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'
import argparse
import sys

class InputProc:
    """Process command line parameters"""
    def __init__(self, desc):
        self.parser = argparse.ArgumentParser(description=desc)
        # configure the parser
        self.parser.add_argument('-f', nargs=1, type=argparse.FileType('r'),
                                 default=sys.stdin, help='process input file '
                                    'named <filename>, if no filename given '
                                    'stdin input are used',
                                 metavar='<filename>', dest='inputfile'
                                 )
        self.parser.add_argument('-c', nargs=1, type=argparse.FileType('r'),
                                 required=True, help='process configuration file'
                                    'input named <config_file.cfg>',
                                 metavar='<config_file.cfg>', dest='cfgfile'
                                 )
        self.parameters = None
        return

    def parse(self, argv=sys.argv):
        """process argv and store options"""
        #args, unknow = self.parser.parse_args(argv, self.parameters)
        args, unknow = self.parser.parse_known_args(argv, self.parameters)
        return args

    def printhelp(self):
        """provide help string"""
        return self.parser.print_help()
