import csv
# Supposed to be used for sorting the dictionary for the classes page
# based on class dates
from operator import itemgetter

from hashlib import new
from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__)

# Global variables for getitng and setting classes from forms
CLASS_PATH = app.root_path + '/classes.csv'
CLASS_KEYS  = ['name', 'type', 'level', 'date', 'duration', 'trainer', 'description']

# This function opens and reads in the classes.csv file as a dictionary.
# It is important to note that we have CLASS_PATH as a global variable
# so that the csv file can be read from any location defined as the
# app.root_path
def get_classes():

    # We put this action in a try/except block so that we can prevent
    # the program from breaking if there is an issue with the csv file
    # (Ex. cannot be read in correctly, does not exist, etc.)
    try:
        with open(CLASS_PATH, 'r') as csvfile:

            # DictReader stores the data from the file into a format
            # that we can loop through and easily store to be read
            data = csv.DictReader(csvfile)
            
            # Dictionary name where we will mostly read and write in
            # classes for this project
            yoga_classes = {}
            for yoga_class in data:
                yoga_classes[yoga_class['name']] = yoga_class

    except Exception as e:
        print(e)

    # Returns the dictionary, where we can read and make changes to if
    # need be (Ex. delete a class)
    return yoga_classes

# This function allows us to actually write to the classes.csv file
# any time we want to add or edit a class. Because the project requires
# us to write into the file for different scenarios (add, edit, or delete), 
# I required a parameter that would be passed in from other functions
# for the sake of simplicity and consistency across the project.
def set_classes(yoga_classes):

    # Similar to when we read in the classes.csv file, we want to put
    # this action into a try/except block so as to not break our program.
    try:
        with open(CLASS_PATH, mode='w', newline='') as csv_file:

            # We established CLASS_KEYS as the headers we want for the
            # csv file. This allows us to only make changes to the global
            # variable if need be.
            writer = csv.DictWriter(csv_file, fieldnames=CLASS_KEYS)
            writer.writeheader()
            
            # Code for writing the rows of data past the headers
            for yoga_class in yoga_classes.values():
                writer.writerow(yoga_class)

    # Except block that notes whenever there are any issues with the
    # try block (Ex. not reading the csv file correctly, not detecting
    # the csv file, etc.)
    except Exception as err:
        print(err)

# App route for the home/index page
@app.route('/')
def index():
    try:
        # We only want the route to direct to the index page, which contains
        # our logo, website information, and button for adding classes
        return render_template("index.html")
    
    except Exception as e:
        print(e)

with open(CLASS_PATH, "r") as csvfile:
    data = csv.DictReader(csvfile)
    
    yoga_classes = {row['name']: {'name':row['name'], 'type':row['type'], 'level':row['level'], 'date':row['date'], 'duration':row['duration'], 'trainer':row['trainer'], 'description':row['description']} for row in data}

# App routes for the classes and individual class pages
@app.route('/classes')
@app.route('/classes/<class_id>')

# This function sets the <class_id> as the default to display the list
# of classes. We will see later how we set the class_id whenever the user
# clicks on an individual class page
def classes(class_id=None):

    try:
        # To display the updated list whenever we add, delete, or edit classes,
        # we need this call to the function here
        yoga_classes = get_classes()

        # This determines whether the <class_id> established from the class.html
        # template matches with the yoga_classes.keys(), which should be the
        # class name if it exists. We then set a class's individual element 
        # to y_class, where we can display the field information for that
        # particular class in the the class.html template
        if class_id and class_id in yoga_classes.keys():
            y_class = yoga_classes[class_id]

            return render_template('class.html', y_class=y_class)

        # As mentioned before, we want to render the classes.html template
        # whenever the <class_id> is set to None. We know that this will always
        # be the case whenever we aren't routed to an individual class page
        else:    
            return render_template('classes.html', yoga_classes=yoga_classes)
    
    except Exception as e:
        print(e)

# App route for adding a class to the dictionary
@app.route('/classes/create', methods=['GET', 'POST'])

# This function first reads in the dictionary and adds a new element
# whenever a user submits the form from the class_form.html template
def create_class(y_class=None):
    try:
        yoga_classes = get_classes()

        # We set the form method as POST in the class_form.html template, which
        # recognizes, requests, and adds values to a newClass dictionary
        # for our yoga_classes dictionary to "read"
        if request.method == 'POST':
            newClass = {}
            
            # Here, we grab the contents of the class_form.html form and store
            # them in the dictionary newClass
            newClass['name'] = request.form['name']
            newClass['type'] = request.form['type']
            newClass['level'] = request.form['level']
            newClass['date'] = request.form['date']
            newClass['duration'] = request.form['duration']
            newClass['trainer'] = request.form['trainer']
            newClass['description'] = request.form['description']
        
            yoga_classes[request.form['name']] = newClass

            # We can write the new data into the classes.csv file to display
            # on the classes page
            set_classes(yoga_classes)

            # To indicate that the form worked, we redirect the user back
            # to the classes page so that the new class entry can be seen
            # on this page
            return redirect(url_for('classes'))
        
        else:
            # We obviously want the form to render whenever the user hasn't
            # entered in a new class; this form will be the default render 
            # unless the POST method from the form is recognized from the if
            # statement above
            return render_template('class_form.html', y_class=y_class)
    
    except Exception as e:
        print(e)

# Route for editing classes
@app.route('/classes/<class_id>/edit', methods=['GET', 'POST'])

# Like the other routes, we need a parameter for <class_id> since we
# want to identify this id whenever we navigate to either the individual
# class_form.html template to edit or the class.html template for that
# specific class
def edit_class(class_id=None):
    try:
        yoga_classes = get_classes()

        # Like the other functions, we use this code to determine and
        # set y_class, or <class_id>, to an individual class if the
        # id exists. In this case, the <class_id> should always exist
        if class_id and class_id in yoga_classes.keys():
            y_class = yoga_classes[class_id]

        # We need to save the results of the form whenever the user
        # updates fields of a class, which is why we can call to the
        # form action using this if statement
        if request.method == 'POST':
            editClass = {}
            
            # Similar to the create_class() function, we store the
            # items of the form into a dictionary called editClass.
            # By setting yoga_classes after grabbing the dictionary,
            # this appears to automatically change the original field
            # information in classes.csv for the class we decided to change
            editClass['name'] = request.form['name']
            editClass['type'] = request.form['type']
            editClass['level'] = request.form['level']
            editClass['date'] = request.form['date']
            editClass['duration'] = request.form['duration']
            editClass['trainer'] = request.form['trainer']
            editClass['description'] = request.form['description']
        
            yoga_classes[request.form['name']] = editClass

            set_classes(yoga_classes)

            # *Note: Changes added seem to not display immediately 
            # after rendering the template in after editing a class. I
            # need to go back to the classes page and then the individual
            # class page to fully see these changes
            return render_template('class.html', y_class=y_class)
    
        else:
            # We need a route to have the user be able to navigate to
            # and edit the form with the class_form.html template. As
            # noted on this template page, y_class should always be equal 
            # to <class_id> in this function, where we added an if 
            # statement to either edit or create a new class given the 
            # status of y_class's existence           
            return render_template('class_form.html', y_class=y_class)
    
    except Exception as er:
        print(er)

# Route for deleting classes
@app.route('/classes/<class_id>/delete', methods=['GET','POST'])

# The last function uses the <class_id> as the parameter and two
# individual form actions to determine the method from the user
# (Ex. Go back to the class vs. delete the class)
def delete_class(class_id=None):
    try:
        yoga_classes = get_classes()

        # Since we only want to delete the class associated with the
        # <class_id>, we want to make sure that the function sets the
        # id and applies it to the delete_form.html template
        if class_id in yoga_classes.keys():
            y_class = yoga_classes[class_id]
            
        # As mentioned, I used two different forms to differentiate
        # between a user going back to and deleting a class. When the
        # user chooses to delete a class, this if statement should run
        # since the template indicates that the form uses POST   
        if request.method == 'POST':

            # We remove the entry of the class returned from get_classes()
            # and use the set_classes() function to apply this change
            yoga_classes.pop(class_id)
            set_classes(yoga_classes)
            
            # We reroute back to the classes page if the user proceeds
            # with deleting a class
            return redirect(url_for('classes'))
            
        else:
            # Here, we render the delete_form.html template if a user
            # wants to proceed with deleting a specific class. We have
            # included buttons to either go back to the class.html
            # template in delete_form.html or the classes page as shown
            # above
            return render_template('delete_form.html', y_class=y_class)
    
    except Exception as e:
        print(e)