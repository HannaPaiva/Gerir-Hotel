from flask import Flask, render_template
from rotas_clientes import rotas_cliente
from rotas_funcionarios import rotas_funcionario
from rotas_departamentos import rotas_departamento
from rotas_pagamentos import rotas_pagamento
app = Flask(__name__, static_folder='assets', static_url_path='/assets')

app.register_blueprint(rotas_cliente)
app.register_blueprint(rotas_funcionario)
app.register_blueprint(rotas_departamento)
app.register_blueprint(rotas_pagamento)

@app.route('/')
def index():
    return render_template('index.html')

if __name__ == "__main__":
    app.run(debug=True)
