__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

#  this module provides problog output parsing capabilities
#  from fileparsing.abfile import ABPropFile
import re
from fileparsing import abutil

class ProbFile:
    """"Wrapper for a problog output file"""
    _specs = None
    _filename = None
    _file = None

    def __init__(self, specs):
        super().__init__()
        self._specs = specs

    def set_file(self, file):
        self._file = file
        self.set_filename(file.name)

    def set_filename(self, filename):
        self._filename = filename

    def get_filename(self):
        return self._filename

    @staticmethod
    def parse_regexp(regexp, record):
        """parse the record to match the regexp"""
        return re.search(regexp, record).groupdict()

    def read_records(self, file):
        #  check endline params

        md = dict(self._specs[0])

        if not md.get('byline'):
            #  todo: implement different record selectors
            #  only parsing records by line atm
            return []

        values = []

        for line in file:
            if md.get('format') == 'regexp':
                values.append(self.parse_regexp(md.get('regexp'), line))

        return values

    def read_file(self):
        if not self._file.closed:
            try:
                record_list = self.read_records(self._file)

                return record_list

            except (IOError, OSError) as e:
                abutil.debug("Some IO Exception occurred")
            except Exception as e:
                abutil.debug("A terrible Exception occurred:{} using {}".format(
                    type(e).__name__, e.args))
                raise e
        return []
