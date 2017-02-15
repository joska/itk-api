# ITk API

## API documentation
The documentation is maintained separately in [Apiary](http://docs.itkpd.apiary.io).

## Vagrant setup
For development, there is a vagrant box ready based on schotch/box. After running it,
several steps are necessary to start the development.

### Open MongoDB
MongoDB is closed for outside connections by default. Run

sudo nano /etc/mongod.conf

And  then comment the line "bindIp: 127.0.0.1". After that, restart mongod service. After that, 
you should be able to acccess the ssh into vagrant machine and run the installation. 


## Installation
cd /var/www/itk.dev
bundle install
bundle exec ruby server.rb

## Run
If installed correctly, you should be able to access the API on http://192.168.33.10:4567.

## ToDo
- finish endpoints
- refactor into modules
- refactor the app into multiple files
- refactor errors
- implement cache
- write unit test
    - attachments
    - datetime and timezones
- implement authorization and authentication
- implement ACL
- stress tests
- logging