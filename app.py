from flask import Flask, render_template

from rotas_clientes import rotas_cliente
from rotas_funcionarios import rotas_funcionario
from rotas_departamentos import rotas_departamento
from rotas_servicos import rotas_servico

from rotas_quartos import rotas_quarto
from rotas_servicos import rotas_servico
from rotas_tarifas import rotas_tarifa

from rotas_agencias import rotas_agencia
from rotas_pagamentos import rotas_pagamento

from rotas_reservas import rotas_reserva

from programa.HP_functions import *

from programa.Z_funcoes import *
from programa.z_database_manager import DatabaseManager

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')


app.register_blueprint(rotas_cliente)
app.register_blueprint(rotas_funcionario)
app.register_blueprint(rotas_departamento)

app.register_blueprint(rotas_quarto)
app.register_blueprint(rotas_servico)
app.register_blueprint(rotas_agencia)

app.register_blueprint(rotas_reserva)
app.register_blueprint(rotas_tarifa)
app.register_blueprint(rotas_pagamento)


@app.route('/')
def index():

    totalClientes = selecionar('''SELECT COUNT(idCliente) AS totalClientes FROM cliente; ''')

    mediaIdades = selecionar(''' SELECT round(AVG(DATEDIFF(CURDATE(), dataNascimento) / 365)) AS mediaIdades
FROM cliente
WHERE dataNascimento IS NOT NULL;
''')

    totalQuartos = selecionar("SELECT COUNT(numQuarto) as totalQuartos from Quarto")

    ocupacao = selecionar('''SELECT
  COUNT(*) AS total_quartos,
  SUM(estaDisponivel) AS quartos_disponiveis,
  (COUNT(*) - SUM(estaDisponivel)) AS quartos_ocupados,
  (SUM(estaDisponivel) / COUNT(*)) * 100 AS ocupacao
FROM
  quarto;

''')
 
    mediaestadia = selecionar("SELECT AVG(DATEDIFF(dataSaida, dataEntrada)) AS mediaestadia FROM reserva;")

    reservasagencia = selecionar("SELECT a.nomeAgencia as nomeagencia, COUNT(*) AS reservasagencia FROM agencia a JOIN reserva r ON a.idAgencia = r.idAgencia GROUP BY a.nomeAgencia;")

    receitamedia = selecionar("SELECT AVG(valorTotal) AS receitamedia FROM pagamento;")

    mediatarifas = selecionar("SELECT AVG(precoNoiteAdulto) AS mediaadultos, AVG(preconoitecrianca) AS mediacriancas FROM tarifa")

    disponiveishoje = free_select('''SET @p_dataAtual = CURRENT_DATE();
SELECT COUNT(*) AS quartos_disponiveis
FROM quarto q
WHERE NOT EXISTS (
    SELECT 1
    FROM reservaquarto rq
    INNER JOIN reserva r ON rq.idReserva = r.idReserva
    WHERE rq.numQuarto = q.numQuarto
        AND (
            (@p_dataAtual BETWEEN r.dataEntrada AND r.dataSaida)
            OR (@p_dataAtual BETWEEN r.dataEntrada AND r.dataSaida)
            OR (r.dataEntrada <= @p_dataAtual AND r.dataSaida >= @p_dataAtual)
        )
);''')
    
    
    quaisdisponiveis = free_select('''
SET @p_dataAtual = CURRENT_DATE();


SELECT CONCAT('Quarto ', q.numQuarto, ', ', q.tipologia, ', no ', q.andar, "º andar") AS descricao_quarto
FROM quarto q
WHERE NOT EXISTS (
    SELECT 1
    FROM reservaquarto rq
    INNER JOIN reserva r ON rq.idReserva = r.idReserva
    WHERE rq.numQuarto = q.numQuarto
        AND (
            (@p_dataAtual BETWEEN r.dataEntrada AND r.dataSaida)
            OR (@p_dataAtual BETWEEN r.dataEntrada AND r.dataSaida)
            OR (r.dataEntrada <= @p_dataAtual AND r.dataSaida >= @p_dataAtual)
        )
);

  ''')
    



    dados = {
        "totalClientes": totalClientes[0]["totalClientes"],
        "mediaIdades": mediaIdades[0]["mediaIdades"],
        "totalQuartos": totalQuartos[0]["totalQuartos"],
        "ocupacao":round(ocupacao[0]["ocupacao"], 2) if ocupacao and ocupacao[0] and ocupacao[0].get("ocupacao") is not None else "Sem dados",
        "mediaEstadia": mediaestadia[0]["mediaestadia"],
        "reservasAgencia": reservasagencia[0]["reservasagencia"],
        "nomeAgencia": reservasagencia[0]["nomeagencia"],
        "receitaMedia": receitamedia[0]["receitamedia"],
        "mediaCriancas": mediatarifas[0]["mediacriancas"],
        "mediaAdultos": mediatarifas[0]["mediaadultos"],

        "quartosDisponiveis": disponiveishoje,
        "quaisDisponiveis": quaisdisponiveis,

    }

    return render_template('index.html', dados=dados)


if __name__ == "__main__":
    app.run(debug=True)
