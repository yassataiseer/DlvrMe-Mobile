import mysql.connector
import os

from decouple import config




class user:
    def connect():
        db =mysql.connector.connect(
        host = "localhost",
        user = "root",
        passwd = "new_password",
        database = "dlvrme")
        return db
    def add_user(username,password):
        db = user.connect()
        mycursor = db.cursor()
        boolean = user.check_if_user_exists(username)
        if boolean == True:
            return {"Status" : False}
        mycursor.execute("INSERT INTO user (Username,Password) VALUES (%s,%s)",(username,password))
        db.commit()
        mycursor.close()
        db.close()
        return {"Status" : True}


    def check_user(user,password):
        db = user.connect()
        mycursor = db.cursor()
        mycursor.execute("SELECT Username FROM user WHERE Username = (%s) AND Password = (%s) ",(user,password))
        data = mycursor.fetchall()
        mycursor.close()
        db.close()
        if len(data)==0:
            return {"Status" : False}
        else:
            return {"Status" : True}


    def check_if_user_exists(user):
        db = user.connect()
        mycursor = db.cursor()
        mycursor.execute("SELECT Username FROM user WHERE Username = (%s) ",(user,))
        data = mycursor.fetchall()
        mycursor.close()
        db.close
        if len(data)==0:
            return  False
        else:
            return  True

 

