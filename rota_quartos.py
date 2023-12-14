from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_quarto = Blueprint("rotas_quarto", __name__)


@rotas_quarto.route('/quartos')
def listar_quartos():
    dados = conn.select_data("quarto")
    action = "pesquisar-quarto"
    if dados is not None:
        return render_template('quartos.html', dados=dados, action = action)
    else:
        return render_template('quartos.html')
    
@rotas_quarto.route('/criar-quarto', methods=['GET', 'POST'])
def criar_quarto():
    dados = {
        "numquarto": request.form["numquarto"],
        "descricao": request.form["descricao"],
        "andar": request.form["andar"],
        "tipologia": request.form["tipologia"],
        "qtdcamacasal": request.form["qtdcamacasal"],
        "qtdcamasolteiro": request.form["solteiro"],
        "ativo": request.form["ativo"],
        "estadisponivel": request.form["estadisponivel"]
    }
    conn.insert_data("quarto", dados)
    return redirect(url_for('rotas_quarto.listar_quartos'))

@rotas_quarto.route('/editar-quarto', methods=['GET', 'POST'])
def editar_quarto():
    numquarto = {"numquarto": request.form["numquarto"]}
    dados = {
        "numquarto": request.form["numquarto"],
        "descricao": request.form["descricao"],
        "andar": request.form["andar"],
        "tipologia": request.form["tipologia"],
        "qtdcamacasal": request.form["qtdcamacasal"],
        "qtdcamasolteiro": request.form["solteiro"],
        "ativo": request.form["ativo"],
        "estadisponivel": request.form["estadisponivel"]
    }
    conn.update_data("quarto", dados, numquarto)
    return redirect(url_for('rotas_quarto.listar_quartos'))

@rotas_quarto.route('/apagar-quarto', methods=['GET', 'POST'])
def apagar_quarto():
    numquarto = {"numquarto": request.form["numquarto"]}
    conn.delete_data("quarto", numquarto)
    return redirect(url_for('rotas_quarto.listar_quartos'))

@rotas_quarto.route('/pesquisar-quarto', methods=['GET', 'POST'])
def pesquisar_quarto():
    param = request.form["param"]
    dados =  conn.select_data(table="quarto", search= param)

    print("dados") 
    if dados:
        return render_template('pesquisa.html', dados = dados)
    else:
        return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])

app.register_blueprint(rotas_quarto)
if __name__ == '__main__':
    app.run(debug=True)