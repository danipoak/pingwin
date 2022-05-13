'''
Basic function to record the date of when you reset your password
and then remind you of when you last reset your password
for usage on HPC environments that require regular password resets
but do not offer a means of reminding the user of when that needs
to take place. The user will have to add running the script
with appropriate CLI options to the users bash. For example
date_time_check.py -r will print the date the last time the password was changed
date_time_check.py -w chained with kpasswd will record the date after
the user changes the password
Author @danipoak

To Do:
1. Add date checker so that if the date is greater than something like
50 days but less than 60 the script will prompt to run kpasswd/passwd
for the user and then follup by running the record date option

'''

import argparse
from datetime import date

parser = argparse.ArgumentParser(description='Process CLI flags')
parser.add_argument('--write', "-w", action='store_true', help='writes the date your password is changed')
parser.add_argument('--read', '-r', action='store_true', help='reads the last date your password was changed')
args = parser.parse_args()

if args.write:
    password_date = date.today()

    print('You have rest your password on:', password_date)

    with open ('password_reset_date.txt', 'w') as f:
        f.write(str(password_date))

if args.read:
    with open ('password_reset_date.txt', 'r') as g:
        last_reset_date = g.readline()
        print('The last time you reset your password was:', last_reset_date)

