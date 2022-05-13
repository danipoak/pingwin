'''
Basic function to record the date of when you reset your password
and then remind you of when you last reset your password
for usage on HPC environments that require regular password resets
but do not offer a means of reminding the user of when that needs
to take place
Author @danipoak
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

