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

    def read_next_line(self, file):
        #  todo: add use cases for different endline chars

        return line

    def read_records(self,file):
        #  check endline params
        if not self._specs[0].byline:
            #  todo: implement different endline char behavior
            return []
        records = []

        for line in file:
            records.append(read_next_line(file))

        values = []

        if self._specs[0].format == 'regexp':
            values = parse_regexp(self._specs[0].regexp, records)

        return values  # todo: add proper behaviour

    def read_file(self):
        if self.filename is not None:
            try:
                record_list = []

                with open(self.filename) as file:
                    record_list.append(self.read_records(file))

            except (IOError, OSError, Failure) as e:
                debug("An terrible exception occurred")

            return record_list
        return []