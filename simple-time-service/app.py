from flask import Flask, jsonify
from datetime import datetime, timezone

app = Flask(__name__)

@app.route('/')
def get_current_time():
    utc_now = datetime.now(timezone.utc)
    return jsonify({
        "current_time": utc_now.isoformat()
    })
