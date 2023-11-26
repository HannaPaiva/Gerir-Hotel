from flask import Flask, render_template
from rotas_clientes import rotas_cliente

app = Flask(__name__, static_folder='assets', static_url_path='/assets')

app.register_blueprint(rotas_cliente)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == "__main__":
    app.run(debug=True)
