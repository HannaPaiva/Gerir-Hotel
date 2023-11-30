from flask import Flask, render_template
from rotas_clientes import rotas_cliente
from rotas_funcionarios import rotas_funcionario
from rotas_departamentos import rotas_departamento
from programa.Z_funcoes import *

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')

app.register_blueprint(rotas_cliente)
app.register_blueprint(rotas_funcionario)
app.register_blueprint(rotas_departamento)

@app.route('/')
def index():

    totalClientes = selecionar('''SELECT COUNT(idCliente) AS totalClientes FROM cliente; ''')

    mediaIdades = selecionar(''' SELECT round(AVG(DATEDIFF(CURDATE(), dataNascimento) / 365)) AS mediaIdades
FROM cliente
WHERE dataNascimento IS NOT NULL;
''')

    totalQuartos = selecionar("SELECT COUNT(numQuarto) as totalQuartos from Quarto")

    porcentagemQuartosOcupados = selecionar('''SELECT
  round((SUM(estaDisponivel) / COUNT(*))) * 100 AS totalQuartosOcupados
FROM
  quarto;''')
    ocupacao = selecionar('''SELECT
  COUNT(*) AS total_quartos,
  SUM(estaDisponivel) AS quartos_disponiveis,
  (COUNT(*) - SUM(estaDisponivel)) AS quartos_ocupados,
  (SUM(estaDisponivel) / COUNT(*)) * 100 AS ocupacao
FROM
  quarto;

''')
 
    
    dados = {
        "totalClientes": totalClientes[0]["totalClientes"],
        "mediaIdades": mediaIdades[0]["mediaIdades"],
        "totalQuartos": totalQuartos[0]["totalQuartos"],
        "totalQuartosOcupados": porcentagemQuartosOcupados[0]["totalQuartosOcupados"]
    }

    return render_template('index.html', dados=dados)





@app.route('/teste')
def teste():

    
    return render_template('teste.html')


if __name__ == "__main__":
    app.run(debug=True)
