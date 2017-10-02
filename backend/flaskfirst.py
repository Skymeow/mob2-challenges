from flask import Flask, request
import json
import pdb
from pymongo import MongoClient
from bson import Binary, Code
from bson.json_util import dumps
# from utils.filename import
from JSONEncoder import JSONEncoder
app = Flask(__name__)

mongo = MongoClient('localhost', 27017)
app.db = mongo.local
# mongo.db is creating a new collection called db
# get courses collection
collection = app.db.courses
# get  parameters of the request
user_course_dict = request.args
# get back one course
@app.route('/courses', methods=["GET"])
def get_courses():
  # get course number and cast it into int
   user_num = int(user_course_dict['number'])
   if user_num is None:
      err = create_error_json("no num url parameter")
      return(err, 404, None)

   object = collection.find_one({"number": user_num})
   # encode/seriolize result, but mongo _id is not json, it's an object, so it doesn't know how to decode
   # use result = object.dumps() or write your own encoder
   result = JSONEncoder().encode(object)
   pdb.set_trace()
   print(result)
   return(result, 200, None)

#get back all courses
@app.route('/courses', methods=["GET"])
def get_all():
  result = collection.find({})
  all_coourses = []
  for i in result:
    all_coourses.append(NewJSONEncoder().encode(i))
  return (all_coourses, 200, None)

# post one course and return the object back
@app.route('/courses', methods=['POST'])
def post_courses():
     course_dict = request.json
     if not 'name' in course_dict or not 'number' in course_dict:
      err = create_error_json('name or num not in json')
      return(err, 404, None)
     collection = app.db.courses
     # courses_json = {"name": "cs3", "number": 224}
     result = collection.insert_one(course_dict)
     courses_json = JSONEncoder().endode(result)
     return (courses_json, 201, None)


# @app.route('/')
# def hello_world():
#     return 'Hello World!'

# @app.route('/person')
# def person_route():
#     json_person = {"name": "Eliel","age": 23}
#     jsonItem = json.dumps(json_person)
#     # caz you can't desplay a json object on web page, so you have to convert it into str or import json
#     # (data, statuscode, header)
#     pdb.set_trace()
#     return (jsonItem, 202, None)


# @app.route('/my_page')
# def page_route():
#     return "yo it's page"

# @app.route('/pets', methods=['GET'])
# def pets_route():
#     pets_json = {'name': 'cat', 'age': 2,
#                  'name2': 'fox', 'age': 1,
#                  'name3': 'dog', 'age': 0.5}
#     pets = json.dumps(pets_json)
#     return (pets, 202, None)
# # @app.route('/pets', methods=['GET'])
# @app.route('/pets', methods=['POST'])
# def pets_request():
#     content = request.json
#     real_data = json.dumps(content)
#     print(real_data)
#     return(real_data)

# # @app.route('/pets', methods=['GET'])
# # def pets_route():
# #     return (pets_request(), 201, None)

if __name__ == '__main__':
    app.config['TRAP_BAD_REQUEST_ERRORS'] = True
    app.run(debug=True)


