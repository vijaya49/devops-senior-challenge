from flask import Flask, jsonify
from datetime import datetime, timezone

app = Flask(__name__)

@app.route('/')
def get_current_time():
    utc_now = datetime.now(timezone.utc)
    return jsonify({
        "current_time": utc_now.isoformat()
    })

# from flask import Flask, render_template
# from datetime import datetime, timezone

# app = Flask(__name__)

# @app.route('/')
# def get_current_time():
#     utc_now = datetime.now(timezone.utc)
#     return render_template('time.html', current_time=utc_now.isoformat())

# if __name__ == '__main__':
#     app.run(debug=True)
