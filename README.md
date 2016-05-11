# eurus-jarvis (open source version)

## introduction

This is a small office adminstration software built on top of rails which is named jarvis.

## prerequirements

you should hava ruby2.2.2&rails-4.2.3 installed on your machine.

## config

config your email settings in config/enviroments/production.rb and development.rb

config your deploy settings in config/deploy/production.rb

config your database settings in config/database.yml

config your wechat settings in wechat.yml

## how to run

run `bundle install` to install all required gems.    
run `rake db:migrate` to generate the scaffold schema.    
run `guard` to start live reload dev.    
run `rails s` to start dev sever.    

## deploy & redeploy

cap production deploy
cap production unicorn:start
cap production deploy:redeploy