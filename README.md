# eurus-jarvis (open source version)

## prerequirements

## config

config your email settings in config/enviroments/production.rb and development.rb

config your deploy settings in config/deploy/production.rb

config your database settings in config/database.yml

config your wechat settings in wechat.yml

## deploy & redeploy

cap production deploy
cap production unicorn:start
cap production deploy:redeploy