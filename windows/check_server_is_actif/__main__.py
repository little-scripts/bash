#!/usr/bin/env python

# Copyright (c) 2014-2022 Matthew Brennan Jones <matthew.brennan.jones@gmail.com>
# Py-cpuinfo gets CPU info with pure Python
# It uses the MIT License
# It is hosted at: https://github.com/workhorsy/py-cpuinfo
#
# Permission is hereby granted, free of charge, to any person obtaining
# a copy of this software and associated documentation files (the
# "Software"), to deal in the Software without restriction, including
# without limitation the rights to use, copy, modify, merge, publish,
# distribute, sublicense, and/or sell copies of the Software, and to
# permit persons to whom the Software is furnished to do so, subject to
# the following conditions:
#
# The above copyright notice and this permission notice shall be included
# in all copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
# EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF
# MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT.
# IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY
# CLAIM, DAMAGES OR OTHER LIABILITY, WHETHER IN AN ACTION OF CONTRACT,
# TORT OR OTHERWISE, ARISING FROM, OUT OF OR IN CONNECTION WITH THE
# SOFTWARE OR THE USE OR OTHER DEALINGS IN THE SOFTWARE.

# Run as module: python -m check_server_is_actif --host <host>

import platform
import subprocess
import logging
from argparse import ArgumentParser

logger = logging.getLogger(__name__)
logging.basicConfig(level=logging.DEBUG)


class CheckServerIsActif:

    def ping(self, host, count=1, wait=3):
        logger.debug("pinging host '%s' (count=%s, wait=%s)", host, count, wait)
        count_switch = '-c'
        if platform.system().lower() == 'windows':
            count_switch = '-n'
        wait_switch = '-w'
        if platform.system().lower() == 'darwin':
            wait_switch = '-W'
        # causes hang if count / wait are not cast to string
        cmd = ['ping', count_switch, '{0}'.format(count), wait_switch, '{0}'.format(wait), host]

        logger.debug(' '.join(cmd))
        try:
            process = subprocess.Popen(cmd, stdout=subprocess.PIPE, stderr=subprocess.PIPE)
            # log.debug('communicating')
            # (stdout, stderr) = process.communicate()
            # log.debug('waiting for child process')
            process.wait()
            exitcode = process.returncode
            #logger.debug('stdout: %s', stdout)
            #logger.debug('stderr: %s', stderr)
            #logger.debug('exitcode: %s', exitcode)
            if exitcode == 0:
                logger.info("host '%s' responded to ping 🤩", host)
                return host
            else:
                logger.warning('ping failed! 😢: %s', host)
        except subprocess.CalledProcessError as _:
            logger.warning('ping failed! 😢: %s', _.output)
        except OSError as _:
            logger.error('error calling ping! 😢: {0}'.format(_))
        return None


if __name__ == "__main__":
    checker = CheckServerIsActif()

    parser = ArgumentParser()
    parser.add_argument('--host', required=True, help='The destination file for the output of this program')
    args = parser.parse_args()

    checker.ping(args.host)
