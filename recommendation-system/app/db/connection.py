import mysql.connector as mydb

def get_connection():
  return mydb.connect(user='root', port='3306', passwd='password', host='db', db='animals')