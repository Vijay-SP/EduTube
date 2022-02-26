from flask import Flask, session, redirect, request, render_template, url_for
import json
from check_login import check_login
from firebase_crud import *


app = Flask(__name__)
app.secret_key = "admin_panel_website"

with open("config.json", "r") as c:
    params = json.load(c)['params']


@app.route("/", methods=["GET", "POST"])
def login():
    # if user is logged in
    if ('user' in session and session['user'] == params['admin_user']):
        return redirect("/properties")

    # If user requests to log in
    if request.method == "POST":
        # Redirect to Admin Panel
        username = request.form.get('uname')
        userpassword = request.form.get('pass')
        if (username == params['admin_user'] and userpassword == params['admin_password']):
            session['user'] = username
            return redirect("/properties")

    return render_template("login.html", params=params)


@app.route("/properties")
@check_login
def properties():
    coursedata = fetchCourse()
    return render_template("properties.html", params=params, course=coursedata, active="course")





@app.route("/buyers")
@check_login
def buyers():
    usersData = fetchBuyers()
    return render_template("buyers.html", params=params, users=usersData,  active="buyers")

@app.route("/contacts")
@check_login
def contacts():
    contacts = fetchContacts()
    return render_template("contacts.html", params=params, contacts=contacts,  active="contacts")



@app.route("/logout")
def logout():
    session.pop('user')
    session.clear()
    return redirect("/")


@app.route("/addproperty", methods=["GET", "POST"])
@check_login
def addproperty():
    # when add button is pressed
    if request.method == "POST":
        # upload the images

        # upload the data to firebase
        uploadPropertyData(request)
        return redirect("/properties")

    return render_template("add_property.html", params=params, active="properties")


@app.route("/property/<id>", methods=["GET", "POST"])
@check_login
def property(id):
    coursedata = fetchCourse()

    if request.method == "POST":

        updateEditedProperty(request, id)
        # check for new floor plan images

        return redirect("/properties")

    return render_template("edit_property.html", params=params, course=coursedata, active="course")


@app.route("/delete/<id>", methods=["GET", "POST"])
@check_login
def deleteProperty(id):
    property = fetchProperty(id)
    # Delete the document from firebase
    deletePropertyFromFirebase(id)

    return redirect("/properties")

@app.route("/deletecontact/<id>", methods=["GET", "POST"])
@check_login
def deletecontact(id):
    # Delete the document from firebase
    deleteContactFromFirebase(id)
    return redirect("/contacts")


if __name__ == '__main__':
    app.run(debug=True)

# CONTACT US

# Add additional data fields in app