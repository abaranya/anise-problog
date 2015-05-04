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
        self.parser.add_argument('-f', nargs='?', type=argparse.FileType('r'),
                                 default=sys.stdin, help='process input file '
                                    'named <filename>, if no filename given '
                                    'stdin input are used',
                                 metavar='<filename>')
        self.parser.add_argument('-c', nargs='1', type=argparse.FileType('r'),
                                 help='process cfg for input processing '
                                    'named <config_file.cfg>',
                                 metavar='<config_file.cfg>'
                                 )
        return

    def parse(self, argv=sys.argv):
        """process argv and store options"""
        return

    def printhelp(self):
        """provide help string"""
        return self.parser.print_help()
