from flask import Flask, request
import json
import pdb
from pymongo import MongoClient
app = Flask(__name__)

mongo = MongoClient('localhost', 27017)
app.db = mongo.local
# mongo.db is creating a new collection called db
# api = Api(app)
# collection = app.db.courses

@app.route('/course', methods=["GET"])
def get_courses():
   collection = app.db.courses
   object = collection.find()
   # data = json.dumps(object)
   # pdb.set_trace()
   # # print(data)
   return(object)



# def put_db():
#      courses_json = {"name": "cs3", "number": "224"}
#      data = collection.insert_one(course_json)
#      return data

# put_db()

@app.route('/courses', methods=['GET','POST'])
def post_courses():
     collection = app.db.courses
     courses_json = {"name": "cs3", "number": 224}
     result = collection.insert_one(courses_json)

     return (result, 201, None)

@app.route('/coursespost', methods=["POST"])
def post_again():
    collection = app.db.courses
    data = collection.insert_one({"name": "jeremy", "number": 20})
    return (None, 201, None)
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


