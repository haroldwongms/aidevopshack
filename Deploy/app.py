from flask import Flask
from score import call_score

app = Flask(__name__)

@app.route("/")
def main(data):
    results = call_score(data)
    return results

if __name__ == "__main__":
    app.run()