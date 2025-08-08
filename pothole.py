import os.path

import pymysql
from flask import Flask, request, jsonify
from werkzeug.utils import secure_filename
from datetime import datetime

flutter = Flask(__name__)
flutter.secret_key = 'abc'
try:
    con = pymysql.connect(host='localhost', user='root', password='root', port=3306, db='pothole_detection', charset='utf8')
    cmd = con.cursor()
except Exception as e:
    print(e)

@flutter.route("/logincheck", methods=['GET', 'POST'])
def logincheck():
    user = request.args.get("email")
    print(user)
    passw = request.args.get("password")
    print(passw)
    cmd.execute("SELECT * FROM login WHERE username=%s AND password=%s", (user, passw))
    result = cmd.fetchone()
    print(result)
    if result is None:
        return jsonify({'task': "invalid"})
    return jsonify({'task': 'success', 'lid': result[0], 'type': result[3]})

@flutter.route("/user_info", methods=['POST'])

def user_info():

        data = request.json
        if not data:
            return jsonify({'error': 'Invalid JSON payload'}), 400

        # Retrieve data from the request
        name = data.get("name")
        dob = data.get("dob")
        gender = data.get("gender")
        mobileno = data.get("mobileno")
        address = data.get("address")
        username = data.get("email")
        password = data.get("password")

        # Validate required fields
        if not (username and password and name):
            return jsonify({'error': 'Missing required fields'}), 400

        # Insert into login table
        cmd.execute("INSERT INTO login (username, password, user_type) VALUES (%s, %s, %s)",
                    (username, password, 'user'))
        con.commit()

        # Fetch the last inserted ID
        user_id = cmd.lastrowid

        # Insert into registration table
        cmd.execute("INSERT INTO registration (name, dob, gender, mobileno, address, lid) "
                    "VALUES (%s, %s, %s, %s, %s, %s)",
                    (name, dob, gender, str(mobileno), address, user_id))
        con.commit()

        return jsonify({'task': 'success'})
@flutter.route("/insertpothole", methods=['GET','POST'])
def insertpothole():
    print(request.form)
    image=request.files.get('file')
    image11= secure_filename(image.filename)
    image.save(os.path.join(image.filename))
    lat=request.form.get('lat')
    log = request.form.get('log')
    area = request.form.get('area')
    des = request.form.get('des')
    lid=request.form.get('id')

    cmd.execute("insert into pothole values(null,'"+image11+"','"+des+"','"+lat+"','"+log+"','"+area+"')")
    con.commit()
    return jsonify({'task': 'success'})


@flutter.route("/userprofile", methods=['GET', 'POST'])
def userprofile():
    try:
        # Retrieve the 'lid' parameter from the request
        lid = request.args.get('lid')

        if not lid:
            return jsonify({'error': 'Missing parameter: lid'}), 400

        # Execute the query with proper parameterization
        cmd.execute("SELECT * FROM registration WHERE lid=%s", (lid,))
        result = cmd.fetchone()

        # Check if a result was found
        if result is None:
            return jsonify({'task': "invalid"})

        # Convert the result into a dictionary
        column_names = [desc[0] for desc in cmd.description]
        result_dict = dict(zip(column_names, result))

        return jsonify(result_dict)
    except Exception as e:
        return jsonify({'error': str(e)}), 500
@flutter.route('/userupdateddata',methods=['post','get'])
def userupdateddata():
    print(request.json)
    data=request.json
    name=data.get('name')
    dob=data.get('dob')
    gender=data.get('gender')
    phone=data.get('phone')
    place=data.get('place')
    lid=data.get('lid')
    cmd.execute("update registration details set name='"+name+"',dob='"+dob+"',gender='"+gender+"',mobileno='"+phone+"',address='"+place+"' where lid='"+str(lid)+"'")
    con.commit()
    return jsonify({'task': 'success'})


@flutter.route("/get_alerts", methods=['GET'])
def get_alerts():
    try:
        # lid = request.args.get('id')  # Get 'id' parameter from query string

        # if not lid:
        #     return jsonify({'error': 'Missing required parameter: id'}), 400

        cmd.execute("SELECT *  FROM pothole")
        result = cmd.fetchall()
        print(result)

        if not result:
            return jsonify({'task': "invalid"})

        # Convert result to a list of dictionaries
        alerts = [
            { 'image': row[1], 'description': row[2], 'area': row[5]}
            for row in result
        ]

        return jsonify({'task': 'success', 'alerts': alerts})

    except Exception as e:
        return jsonify({'error': str(e)}), 500

@flutter.route("/get_location", methods=['GET'])
def get_location():
    try:
        # lid = request.args.get('id')  # Get 'id' parameter from query string

        # if not lid:
        #     return jsonify({'error': 'Missing required parameter: id'}), 400

        # Execute SQL query safely using parameterized query
        cmd.execute("SELECT id, Latitude, Longitude FROM pothole ")
        result = cmd.fetchall()
        print(result,'**************')

        if not result:
            return jsonify({'task': "invalid"})

        # Convert result to a list of dictionaries
        alerts = [{'id': row[0], 'lat': row[1], 'log': row[2], } for row in result]

        return jsonify({'task': 'success', 'alerts': alerts})

    except Exception as e:
        return jsonify({'error': str(e)}), 500


# @flutter.route('/userupdateddata', methods=['POST'])
# def update_user():
#     try:
#         data = request.get_json()
#
#         # Validate required fields
#         required_fields = ['email', 'name', 'dob', 'gender', 'mobileno', 'address', 'password']
#         if not all(field in data for field in required_fields):
#             return jsonify({'error': 'Missing required fields'}), 400
#
#         # Find user by email
#         user = User.query.filter_by(email=data['email']).first()
#         if not user:
#             return jsonify({'error': 'User not found'}), 404
#
#         # Update user details
#         user.name = data['name']
#         user.dob = data['dob']
#         user.gender = data['gender']
#         user.mobile = data['mobileno']
#         user.address = data['address']
#         user.password = data['password']  # In production, hash the password!
#
#         db.session.commit()
#
#         return jsonify({
#             'message': 'User updated successfully',
#             'user': {
#                 'id': user.id,
#                 'name': user.name,
#                 'email': user.email,
#                 'mobile': user.mobile,
#                 'address': user.address
#             }
#         }), 200
#
#     except Exception as e:
#         db.session.rollback()
#         return jsonify({'error': str(e)}), 500
#


flutter.run(host='0.0.0.0',port=5000,debug=True)