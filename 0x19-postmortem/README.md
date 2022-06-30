# 0x19-postmortem

# Issue Summary

11/01/2022 From 9:15 AM to 10:00 AM EAT when we requested for the homepage to our servers got a 404 response

# Timeline
- 9:10 AM : Updated push
- 9:15 AM : Noticed the problem
- 9:15 AM : Notifyed both the front end and backend teams
- 9:20 AM : Successfully changed rollback
- 9:24 AM : Server Restarts begun
- 9:27 AM : 100% of traffic got back online
- 9:30 AM : started debugging the push with the problem
- 9:50 AM : Problem fixed and pushed the changes
- 9:55 AM : Server restart begun again
- 10:00 AM : 100% traffic was back online with the new updates

# Root cause and resolution

From stepping back we were able to discern that the problem came from the changes made by the front end team. We took their modifications and run them on a test server which replicated the same problem. Our server used apache2 and apache2 error logs didn't give enought infomation about the problem so we traced the apache2 process using strace and when a request was sent the strace tool caught a lot of errors and after some scaning, we found the error which was a typo in the page file extention >
> .phpp

instead of 

> .php

To fix that we went on to search in our main directory using grep for that typo
> grep -inR ".phpp" .

after fixing the error we pushed back the changes and restarted the servers
- 10:00 AM : 100% of trafic went back online with the new updates.

# Corrective and preventative measures

To prevent similar problems from happening again we decided to:
- Create an automated test pipeline for every update push.
- Add a monitoring software to our servers to monitor several issues and one of them Network Traffic resquests and responses and configure it to make an lert to the teams when too much non-wanted responses are sent like 404.
- Create tests for every new update and for the teams not push until those tests pass.