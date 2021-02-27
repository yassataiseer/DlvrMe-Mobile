import mysql.connector
import os

from decouple import config

db =mysql.connector.connect(
    host = "localhost",
    user = "root",
    passwd = "new_password",
    database = "dlvrme"
)
mycursor = db.cursor()


class user:
    def add_user(username,password):
        boolean = user.check_if_user_exists(username)
        if boolean == True:
            return {"Status" : False}
        mycursor.execute("INSERT INTO user (Username,Password) VALUES (%s,%s)",(username,password))
        db.commit()
        return {"Status" : True}


    def check_user(user,password):
        mycursor.execute("SELECT Username FROM user WHERE Username = (%s) AND Password = (%s) ",(user,password))
        data = mycursor.fetchall()
        if len(data)==0:
            return {"Status" : False}
        else:
            return {"Status" : True}

        
    def check_if_user_exists(user):
        mycursor.execute("SELECT Username FROM user WHERE Username = (%s) ",(user,))
        data = mycursor.fetchall()
        if len(data)==0:
            return  False
        else:
            return  True

 

