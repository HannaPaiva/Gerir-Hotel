from flask import Flask, render_template
from flask_assets import Environment, Bundle
from rotas_clientes import rotas_cliente
from rotas_funcionarios import rotas_funcionario
from rotas_departamentos import rotas_departamento
from programa.Z_funcoes import *
from programa.z_database_manager import DatabaseManager


conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')

assets = Environment(app)
query_bundle = Bundle(
    'https://code.jquery.com/jquery-3.6.4.min.js',
    output='gen/jquery.js'
)

# Adicione o pacote ao ambiente de ativos
assets.register('jquery', query_bundle)




app.register_blueprint(rotas_cliente)
app.register_blueprint(rotas_funcionario)
app.register_blueprint(rotas_departamento)

# main_routes




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





@app.route('/pesquisar')
def pesquisar():

    
      return render_template('pesquisar.html')



@app.route('/teste')
def teste():

    
      return render_template('teste.html')



if __name__ == "__main__":
    app.run(debug=True)
