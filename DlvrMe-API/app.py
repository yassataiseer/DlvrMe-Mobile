import mysql.connector
from flask import Flask, jsonify
from flask_restful import Api, Resource, reqparse, abort, fields, marshal_with
import os
from user_manager import user
from order_manager import order
app = Flask(__name__)
api = Api(app)

"""Users"""
class mk_user(Resource):
    def get(self,Username,Password):
        status = user.add_user(Username,Password)
        return jsonify(status)

class validate_user(Resource):
    def get(self,Username,Password):
        status = user.check_user(Username,Password)
        return jsonify(status)
"""Orders"""
class mk_order(Resource):
    def get(self,Username,Address,Item,Price,User_Info):
        status = order.add_order(Username,Address,Item,Price,User_Info)
        return jsonify(status)
class del_order(Resource):
    def get(self,Username,Address,Item,Price,User_Info):
        status = order.delete_order(Username,Address,Item,Price,User_Info)
        return jsonify(status)
class all_order(Resource):
    def get(self):
        data = order.get_order()
        return jsonify(data)
class spec_order(Resource):
    def get(self,Username):
        data = order.get_order_specific_person(Username)
        return jsonify(data)
class find_address(Resource):
    def get(self,Address):
        status = order.grab_address(Address)
        return jsonify(status)
class validate_address(Resource):
    def get(self,Address):
        status = order.validate_address(Address)
        return jsonify(status)
api.add_resource(mk_user,"/mk_user/<string:Username>/<string:Password>")
api.add_resource(validate_user,"/validate_user/<string:Username>/<string:Password>")
api.add_resource(mk_order,"/mk_order/<string:Username>/<string:Address>/<string:Item>/<float:Price>/<string:User_Info>")
api.add_resource(del_order,"/del_order/<string:Username>/<string:Address>/<string:Item>/<float:Price>/<string:User_Info>")
api.add_resource(all_order,"/all_order")
api.add_resource(spec_order,"/spec_order/<string:Username>")
api.add_resource(find_address,"/find_address/<string:Address>")
api.add_resource(validate_address,"/validate_address/<string:Address>")
if __name__ == "__main__":
	app.run(host='10.0.0.63', port=5000 ,debug=True)
