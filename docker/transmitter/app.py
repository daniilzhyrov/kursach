import os
from flask import Flask
import pymongo

app = Flask(__name__)

mongo_address = os.environ["MONGO_ADDRESS"] if "MONGO_ADDRESS" in os.environ and os.environ["MONGO_ADDRESS"] else "mongodb://mongo-0.mongo.kursach.svc.cluster.local,mongo-1.mongo.kursach.svc.cluster.local,mongo-2.mongo.kursach.svc.cluster.local:27017/dbname\_?"
mongo_database_name = os.environ["MONGO_DATABASE"] if "MONGO_DATABASE" in os.environ and os.environ["MONGO_DATABASE"] else "flights"

mongo_client = pymongo.MongoClient(mongo_address)
mongo_db = mongo_client[mongo_database_name]

@app.route('/', methods = ['POST'])
def insert():
    mycol = mongo_db["flights"]
    mydict = { "name": "John", "address": "Highway 37" }
    x = mycol.insert_one(mydict)
    return 'OK', 201

if __name__ == "__main__":
    app.run(host="0.0.0.0", debug=True)