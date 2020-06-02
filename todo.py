from datetime import datetime

with open('/code/time.log', 'a') as file:
    file.write(str(datetime.now()) + ' \n')

print('Done')
