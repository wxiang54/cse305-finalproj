# cse305_finalproj
Final project for CSE305 (Spring 2019)

## Project Overview
- The name of the Django project is called **crows_foot**. Note that this is the top-level project directory, and inside it there is an app with the same name.
- In this project there are two so-called "apps":
  - The **crows_foot** app manages the overall function of the entire project, and houses things like settings and configs.
  - The **main** app deals with everything else, because there wasn't enough time to delegate responsibilities between separate apps.
- Inside the (top-level) project directory is a file called **manage.py**. This command is used to run admin-related managerial tasks. See below.

## Project Setup (one-time setup)
1. Activate the python virtual environment.
2. Import all dependencies needed for the project:
```sh
$ python -m pip install requirements.txt
```
3. Set up MySQL local database.
    * MySQL Server downloads for each OS is available [here](https://dev.mysql.com/downloads/mysql/).
    * During installer setup, be sure that you name of the root user of your local database "root".
4. Create **secrets.py** file in the crows_foot app directory. The entire contents of this file should be as follows:
```py
SECRET_KEY = '<secret key of django project>'
DB_PASSWORD = '<password of root user of MySQL db>'
```
5. Migrate the database, which adds a few tables to your MySQL database and helps Django run properly:
```sh
$ cd <my_project_dir>
$ python manage.py migrate
```

## Running the Project
- Run the Django web server:
```sh
$ python manage.py runserver
```
- You can check what is being served through your browser, by going to the URL "localhost:8000".

## Development: Defining your own URLs
In this example, I'll be adding a URL called "/test", so it would be accessed at "localhost:8000/test". However you should use whatever name actually fits the function of the webpage, so if you're making a signup page, then you should call the URL "/signup" or something similar.
1. Put your .html file in the directory `crows_foot/main/templates/`. The static files (e.g. images) that your .html file relies on should go in `crows_foot/main/static/`.
2. Format your .html file so that it extends the **layout.html** file, and defines the content in the individual blocks.
    * You can see many examples of this in the current templates, like "homepage.html" and "cart.html".
3. In **views.py**, define the function that you want to be called when you access the "localhost:8000/test" URL in a browser.

```py
from django.shortcuts import render

def home(request):
    return render(request, "homepage.html")

...

def test(request):  # our new function!
    return render(request, "<your_html_file_here>")
```
4. Add the URL to the **urls.py** file in the **main** app directory.

```py
from django.urls import path
from . import views

urlpatterns = [
    path('', views.home, name="home"),
    ...
    path('test/', views.test, name="test"),  # our new URL!
]
```

    * The first string "test/" should be the URL that calls your function in "views.py". It doesn't necessarily have to be called the same thing (e.g. you could define a URL "localhost:8000/foo" that calls the function `bar` in "views.py"), but usually it makes the most sense.
    * Replace `views.test` with the actual function name you defined in "views.py", like `views.signup` for example.
    * The name can really be anything, but it's still nice to name the URL something that actually fits.

5. You should now be able to access your webpage at "localhost:8000/test". If there were errors in serving your page, Django will report them to you on that page.
