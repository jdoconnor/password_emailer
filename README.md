# Password Emailer

## Setup
A Redis instance
A Mandrill API key

Set the following environment variables.  Replace with your values (SECRET_KEY, SALT, and IV can be whatever)

```
SECRET_KEY='SOME_KEY'
SALT='SOME_SALT'
IV='SOME_VECTOR'
MANDRILL_API_KEY='YOUR_API_KEY'
FROM_EMAIL='THE_ADDRESS_THAT_THE_EMAIL_IS_SENT_FROM'
SERVER_URL='http://your-server.example.com'
```
