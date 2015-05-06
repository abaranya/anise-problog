__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

import configparser
from fileparsing import abutil

# this module provides generic file parsing capabilities
# is intended for generic but personal use

# define generic property file


class ABPropFile:
    """Handle generic config file for the parsing class"""
    filename = 'abfile.cfg'
    parser = configparser.ConfigParser()

    def __init__(self, filename='abfile.cfg'):
        self.filename = filename

    def __init__(self, fileobject):
        self.filename = fileobject.name

    def get_cfg_type_section(self):
        """read [ABFile]section"""
        if self.parser.has_section('ABFile'):
            return self.parser.get('ABFile')
        return None

    def get_definition(self):
        """process & store configuration definition internally"""
        self.parser.read(self.filename)
        abutil.debug("Secciones : " + self.parser.sections())
        #  identify cfg type
        absection = self.get_cfg_type_section()
        return absection

    def parsebody(self):
        # todo do some actual body parsing
        return 'Body'

    def parseheader(self):
        # todo do some header parsing
        return 'Header'

    def parse(self):
        # todo how about return the body and the header
        return {self.parseheader(), self.parsebody()}
