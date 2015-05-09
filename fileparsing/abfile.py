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
# Record section
RECORD = 'Record'

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

    @property
    def has_header(self):
        """test if processing header is required"""
        return (self.parser.get(HEADER, 'header') == 'True')

    def get_cfg_type_section(self):
        """read [ABFile] section"""
        if self.is_valid_abfile:
            return self.parser.items(ABFILE)
        return None

    def get_definition(self):
        """process & store configuration definition internally"""
        section_list = self.parser.sections()
        abutil.debug("Secciones : {}".format(section_list))

        if ABFILE in section_list:
            #  identify cfg type
            absection = self.get_cfg_type_section()
        else:
            absection = "Invalid property file"

        return absection

    def get_record_definition(self):
        """get definition for a record style cfg"""
        return self.parser.items(RECORD)  # Set proper return value

    def parsebody(self):
        # todo do some actual body parsing
        return 'Body'

    def parseheader(self):
        # check if file requires header processing
        if not self.has_header:
            return None

        # todo process header section
        return None

    def parse(self):
        """"process cfg file definition"""
        # read the file and paser the structure
        self.parser.read(self.filename)

        if not self.is_valid_abfile:
            return {None, None}

        # get general cfg definition
        cfg_definition = self.get_definition()

        #  todo: delete this testing behavior
        abutil.debug("cfg definition is --{}--".format(cfg_definition))

        #  verify record style input file
        (prop, value) = next(((a, b) for (a, b) in cfg_definition if a == 'style'
                              ), (None, None)
                             )
        if not value == 'record':  # should check text and single conditions
            return {None, None}

        return {self.parseheader(), self.parsebody(value)}
