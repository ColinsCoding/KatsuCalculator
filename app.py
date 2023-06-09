from flask import Flask, request, jsonify

app = Flask(__name__)

@app.route('/test', methods=['GET'])
def test_communication():
    return jsonify({"message": "Server is communicating properly"})

@app.route('/convert', methods=['POST'])
def convert_to_kilograms():
    data = request.json
    
    # Extract the amount in grams from the input data
    amount_in_grams = data.get('amount')
    
    # Validate the input data
    if amount_in_grams is None:
        return jsonify({"error": "Amount is required"}), 400
    
    # Convert grams to kilograms
    amount_in_kilograms = amount_in_grams / 1000
    
    # Return the result
    return jsonify({"result": amount_in_kilograms, "unit": "kilograms"})


if __name__ == '__main__':
    app.run(debug=True)
