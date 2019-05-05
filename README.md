# cse305_finalproj
Final project for CSE305 (Spring 2019)

## Project Overview
- The name of the Django project is called **crows_foot**. Note that this is the top-level project directory, and inside it there is an app with the same name.
- In this project there are four "apps", called crows_foot, item_management, order_management, and user_management.
  - The **crows_foot** app manages the overall function of the entire project, and houses things like settings and configs.
  - The **user_management** app deals with managing users, like the name implies. Responsibilities are user login, registration, account management, session handling, etc.
  - The **item_management** app deals with shopping cart, item stocks, item search, etc.
  - The **order_management** app deals with order fulfillment (shipping), payment, and possibly reviews.
- Inside the (top-level) project directory is a file called **manage.py**. This command is used to run admin-related managerial tasks. See below.

## Project Setup (one-time setup)
1. Activate the python virtual environment.
2. Import all dependencies needed for the project:
```sh
$ python -m pip install requirements.txt
```
3. Set up MySQL local database.
  - Be sure to name the root user "root".
4. Create **secrets.py** file in the crows_foot app directory. The contents of this file should be as follows:
```py
SECRET_KEY = '<secret key of django project>'
DB_PASSWORD = '<password of root user of MySQL db>'
```
5. Migrate the database, which adds a few tables to your MySQL database and helps Django run properly:
```sh
  $ python manage.py migrate
```

## Running the Project
- Run the Django web server:
```sh
$ python manage.py runserver
```
