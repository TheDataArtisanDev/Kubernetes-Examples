from flask import Flask

app = Flask(__name__)
crash_flag = {"dead": False}

@app.route('/')
def hello():
    return "Hello from Flask on Kubernetes!"

@app.route('/healthz')
def liveness():
    if crash_flag["dead"]:
        return "App is dead 💀", 500
    return "I'm alive!", 200

@app.route('/ready')
def readiness():
    return "I'm ready!", 200

@app.route('/crash')
def crash():
    crash_flag["dead"] = True
    return "App will now fail liveness probe!", 200

if __name__ == '__main__':
    app.run(host='0.0.0.0', port=5000)