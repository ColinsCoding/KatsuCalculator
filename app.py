#import neccesary libraries
from flask import Flask, request, jsonify

# create a Flask app instance | app is an object of class Flask
app = Flask(__name__)


# define a route for the default URL, which loads the form | route() decorator binds a function to a URL 
@app.route('/calculate', methods=['POST'])
def calculate_recipe():

    # Get the input data from the request
    data = request.json
    
    # Extract the amount and unit from the input data
    amount = data.get('amount')
    unit = data.get('unit')
    
    # Validate the input data
    if amount is None or unit is None:
        return jsonify({"error": "Amount and unit are required"}), 400

    # Perform calculations here, for example, converting to grams
    if unit == 'pounds':
        amount_in_grams = amount * 453.592
    elif unit == 'ounces':
        amount_in_grams = amount * 28.3495
    else:
        return jsonify({"error": "Invalid unit"}), 400
    
    # Here you can add more logic if needed.
    
    # Return the result
    return jsonify({"result": amount_in_grams, "unit": "grams"})

# run the Flask app
if __name__ == '__main__':
    app.run(debug=True)
