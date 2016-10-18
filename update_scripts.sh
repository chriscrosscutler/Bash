#!/bin/bash

@daily /bin/execute/this/script.sh



As the links described as harish.venkat

Create a script /path_to_script, which would add new file, commit and push.

#!/bin/sh
cd /location/of/clone

git add *
if [[ $? != 0 ]] then
   mail -s "add failed" someone@some.com
   exit 1
fi

git commit -a -m "commit message, to avoid being prompted interactively"
if [[ $? != 0 ]] then
   mail -s "commit failed" someone@some.com
   exit 1
fi

git push
if [[ $? != 0 ]] then
   mail -s "push failed" someone@some.com
   exit 1
fi

mail -s "push ok" someone@some.com
Change the script to executable,

chmod a+x /path_to_script
Use crontab -e and add below line

 # run every night at 03:00
 0 3 * * * /path_to_script
