from flask import Flask
from flask import jsonify
from flask import request, make_response
from score import call_score
import json

app = Flask(__name__)
app.debug=True
@app.route("/", methods=['POST'])
def main():
    data = json.loads(request.form['data'], encoding="utf-8")
    results = call_score(data)
    return jsonify(results.tolist())

if __name__ == "__main__":
    app.run(host='0.0.0.0')