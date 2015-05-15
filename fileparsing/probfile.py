__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

#  this module provides problog output parsing capabilities
#  from fileparsing.abfile import ABPropFile


class ProbFile:
    """"Wrapper for a problog output file"""
    _specs = None
    _filename = None

    def __init__(self, specs):
        super().__init__()
        self._specs = specs

    def set_filename(self, filename):
        self._filename = filename

    def get_filename(self):
        return self.filename

    def read_record(self,file):
        return []  # todo: add proper behaviour

    def read_file(self):
        if self.filename is not None:
            try:
                record_list = []

                with open(self.filename) as file:
                    record_list.append(self.read_record(file))

            except (IOError, OSError, Failure) as e:
                debug("An terrible exception occurred")

            return record_list
        return []