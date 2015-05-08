__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

import configparser
from fileparsing import abutil

# this module provides generic file parsing capabilities
# is intended for generic but personal use

# property file tag
ABFILE = 'ABFile'
# Header Section
HEADER = 'Header'


class ABPropFile:
    """Handle generic config file for the parsing class"""
    filename = 'abfile.cfg'
    parser = configparser.ConfigParser(allow_no_value=True)

    def __init__(self, filename='abfile.cfg'):
        """
        Base constructor
        :str filename: name of configuration file
        """
        self.filename = filename

    def __init__(self, fileobject):
        """
        Base constructor
        :param fileobject:
        """
        self.filename = fileobject.name

    @property
    def is_valid_abfile(self):
        """Test if 'ABFile' is present"""
        return self.parser.has_section(ABFILE)

    def get_cfg_type_section(self):
        """read [ABFile] section"""
        if self.is_valid_abfile:
            return self.parser.items(ABFILE)
        return None

    def get_definition(self):
        """process & store configuration definition internally"""
        self.parser.read(self.filename)
        section_list = self.parser.sections()
        abutil.debug("Secciones : {}".format(section_list))

        if ABFILE in section_list:
            #  identify cfg type
            absection = self.get_cfg_type_section()
        else:
            absection = "Invalid property file"

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
