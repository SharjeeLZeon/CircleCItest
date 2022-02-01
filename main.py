#from flask import Flask
#app = Flask(__name__)

#@app.route('/')
#def hello_world():
#   return "Hello World"

#if __name__ == '__main__':
#   app.run() 
import os
print("Hellow world")
print("Current Working Directory " , os.getcwd())
    
    
try:
    # Change the current working Directory    
    os.chdir("/usr/bin/python")
    print("Directory changed")
except OSError:
    print("Can't change the Current Working Directory")