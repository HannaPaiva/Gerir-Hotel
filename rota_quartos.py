from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.AT_quarto import *
from programa.z_database_manager import DatabaseManager

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_quarto = Blueprint("rotas_quarto", __name__)


@rotas_quarto.route('/quarto')
def listar_quarto():
    dados = conn.select_data("quarto")
    if dados is not None:
        return render_template('quarto.html', dados=dados)
    else:
        return render_template('quarto.html')

@rotas_quarto.route('/criar-quarto', methods=['GET', 'POST'])
def criar_quarto():
    dados = {
        "descricao": request.form["descricao"],
        "andar": request.form["andar"],
        "tipologia": request.form["tipologia"],
        "qtdcamacasal": request.form["qtdcamacasal"],
        "qtdcamasolteiro": request.form["qtdcamasolteiro"],
        "ativo": request.form["ativo"],
        "estadisponivel": request.form["estadisponivel"],
    }
    conn.insert_data("quarto", dados)
    return redirect(url_for('rotas_cliente.listar_clientes'))

@rotas_quarto.route('/editar-quarto', methods=['GET', 'POST'])
def editar_cliente():
    numquarto = {"numquarto": request.form["numquarto"]}
    dados = {
        "descricao": request.form["descricao"],
        "andar": request.form["andar"],
        "tipologia": request.form["tipologia"],
        "qtdcamacasal": request.form["qtdcamacasal"],
        "qtdcamasolteiro": request.form["qtdcamasolteiro"],
        "ativo": request.form["ativo"],
        "estadisponivel": request.form["estadisponivel"],
    }
    conn.update_data("quarto", dados, numquarto)
    return redirect(url_for('rotas_cliente.listar_clientes'))

    