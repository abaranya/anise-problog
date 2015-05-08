__author__ = 'Alexander Baranya'
__email__ = 'abaranya@gmail.com'
__username__ = 'abaranya'

# this module provides generic utilities
# is intended for generic but personal use

# define debug flag

ab_use_debug = True

#
#  function to print debuging info
#


def debug(message):
    if ab_use_debug:
        print("Debug_Message: {}".format(message))
    return

