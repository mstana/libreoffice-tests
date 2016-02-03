#!/usr/bin/env python

import sys
import os
import tempfile
from subprocess import check_output, check_call, CalledProcessError, STDOUT
import logging

test_dir = os.getcwd()
dist_lib = "/usr/lib64/libreoffice"
lib_dir = os.path.join(test_dir, 'lib')
usr_dir = tempfile.mkdtemp(prefix='smoketest-')

cppu = os.path.join(test_dir, 'bin', 'cppunittester')


def run_smoketest():
    logging.info("Running smoketest ...")

    os.environ['JAVA_HOME'] = os.readlink(
        "/etc/alternatives/java").rstrip("bin/java")
    os.environ['LD_LIBRARY_PATH'] = ':'.join([os.path.join(lib_dir),
                                             os.path.join(
                                                 dist_lib, 'ure', 'lib'),
                                             os.path.join(dist_lib, 'program')])
    logging.debug("LD_LIBRARY_PATH = {[LD_LIBRARY_PATH]}".format(os.environ))

    cmd = [
        cppu,
        os.path.join(lib_dir, 'libtest_smoketest.so'),
        "-env:UNO_SERVICES=file://" + os.path.join(lib_dir, 'services.rdb'),
        "-env:UNO_TYPES=file://" + os.path.join(lib_dir, 'types.rdb') +
        " file://" + os.path.join(lib_dir, 'offapi.rdb'),
        "-env:arg-soffice=path:" + soffice_bin,
        "-env:arg-user=" + usr_dir,
        "-env:arg-env=" + os.environ['LD_LIBRARY_PATH'],
        "-env:arg-testarg.smoketest.doc=" + os.path.join(
            test_dir, 'doc', 'smoketestdoc.sxw'),
        "--protector" + os.path.join(lib_dir, 'unoexceptionprotector.so') +
        "unoexceptionprotector",
        "--protector" + os.path.join(lib_dir, 'unobootstrapprotector.so') +
        "unobootstrapprotector"
    ]
    logging.debug("Smoketest command: " + " ".join(cmd))
    try:
        check_call(cmd)
        logging.info("Smoketest PASSED")
        return True
    except CalledProcessError:
        logging.error("Smoketest FAILED")
        return False


if __name__ == '__main__':
    FORMAT = '%(asctime)s :: [ %(levelname)s ] :: %(message)s'
    DATEFMT = '%H:%M:%S'
    logging.basicConfig(stream=sys.stdout, level=logging.INFO, format=FORMAT,
                        datefmt=DATEFMT)

    try:
        soffice_bin = check_output(["which", "soffice"], STDOUT).rstrip()
        logging.debug("Using binary " + soffice_bin)
    except CalledProcessError, err:
        logging.error("No such binary: " + err.output)
        sys.exit(1)

    if run_smoketest():
        sys.exit()
    else:
        sys.exit(1)
