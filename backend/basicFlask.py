from flask import Flask, request, make_response
from flask_restful import Resource, Api
from pymongo import MongoClient

# Basic Setup
# 1
app = Flask(__name__)
# 2
mongo = MongoClient('localhost', 27017)
# 3
app.db = mongo.develop_database
# 4
api = Api(app)
