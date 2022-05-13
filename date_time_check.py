from datetime import date

password_date = date.today()

print('You have rest your password on:', password_date)

with open ('password_reset_date.txt', 'w') as f:
    f.write(str(password_date))

with open ('password_reset_date.txt', 'r') as g:
    last_reset_date = g.readline()
    print('The last time you reset your password was:', last_reset_date)