__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

import configparser

# this module provides generic file parsing capabilities
# is intended for generic but personal use

# define generic property file


class ABPropFile:
    """Handle generic config file for the parsing class"""
    filename = 'abfile.cfg'
    parser = configparser.ConfigParser()

    def __init__(self, filename='abfile.cfg'):
        self.filename = filename

    def getdefinition(self):
        """process & store configuration definition internally"""
        # todo uncomment this self.parser.read(self.filename)
        return "getting definition"

    def parsebody(self):
        # todo do some actual body parsing
        return 'Body'

    def parseheader(self):
        # todo do some header parsing
        return 'Header'

    def parse(self):
        # todo how about return the body and the header
        return {self.parseheader(), self.parsebody()}
