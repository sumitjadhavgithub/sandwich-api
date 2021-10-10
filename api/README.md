# README
The repository main purpose is to provide API to sandwich consumer app. API is accessible throgh user authentication which is configured using doorkeepr. API's are designed using Rails 5.

# Development setup
Steps for setting up a dev environment on Mac OS X. 

Before getting started, you'll need to install: 
- [Homebrew](http://brew.sh/).  
- [RVM](https://rvm.io/rvm/install) 

Install stuff with [Homebrew]:
- Open Terminal
- `rvm install 2.7.0` 
- `brew install postgresql`
- `gem install postgresql`
- `gem install bundler`

Then:
Navigate your terminal to the api directory of the sandwich-api application
- `bundle install`
- `rake db:migrate`
- `rails server`

All set, API's are ready!

# NOTE 
To access API you will required user, create user using below API details in the Postman:

- URL- http://localhost:3000/api/users
- Method - POST
- Body(json) - `{
    "email": <user_name>,
    "password": <passowrd>,
    "client_id": "TQXWDJYJZUELOTSGILGBKUAQQLNEIKDJDJIZ"
}`