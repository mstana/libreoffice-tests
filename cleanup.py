#!/bin/env python
import os

# Remove all the remains of other files
os.system("rm /tmp/test_files -rf")
os.system("rm /tmp/myDB1.odb -rf")
os.system("rm /tmp/formula.odt -rf")

# Make sure we have a test files present
os.system("cp -r test_files /tmp")

home_dir = os.path.expanduser('~')
config_dir = '.config/libreoffice'
full_config_path = os.path.join(home_dir, config_dir)
os.system('rm -rf %s' % full_config_path)
