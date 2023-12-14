from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_hospede = Blueprint("rotas_hospede", __name__)


@rotas_hospede.route('/hospedes')
def listar_hospedes():
    dados = conn.select_data("hospede")
    action = "pesquisar-hospede"
    if dados is not None:
        return render_template('hospedes.html', dados=dados, action = action)
    else:
        return render_template('hospedes.html')
    
@rotas_hospede.route('/criar-hospede', methods=['GET', 'POST'])
def criar_hospede():
    dados = {
        "primeironome": request.form["primeironome"],
        "nomedomeio": request.form["nomedomeio"],
        "ultimonome": request.form["ultimonome"],
        "cc": request.form["cc"],
        "email": request.form["email"],
        "telefone": request.form["telefone"],
        "datanascimento": request.form["datanascimento"],
        "ativo": request.form["ativo"]
    }
    conn.insert_data("hospede", dados)
    return redirect(url_for('rotas_hospede.listar_hospedes'))

@rotas_hospede.route('/editar-hospede', methods=['GET', 'POST'])
def editar_hospede():
    idhospede = {"idhospede": request.form["idhospede"]}
    dados = {
        "primeironome": request.form["primeironome"],
        "nomedomeio": request.form["nomedomeio"],
        "ultimonome": request.form["ultimonome"],
        "cc": request.form["cc"],
        "email": request.form["email"],
        "telefone": request.form["telefone"],
        "datanascimento": request.form["datanascimento"],
        "ativo": request.form["ativo"]
    }
    conn.update_data("hospede", dados, idhospede)
    return redirect(url_for('rotas_hospede.listar_hospedes'))

@rotas_hospede.route('/apagar-hospede', methods=['GET', 'POST'])
def apagar_hospede():
    idhospede = {"idhospede": request.form["idhospede"]}
    conn.delete_data("hospede", idhospede)
    return redirect(url_for('rotas_hospede.listar_hospedes'))

@rotas_hospede.route('/pesquisar-hospede', methods=['GET', 'POST'])
def pesquisar_hospede():
    param = request.form["param"]
    dados =  conn.select_data(table="hospede", search= param)

    print("dados") 
    if dados:
        return render_template('pesquisa.html', dados = dados)
    else:
        return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])

app.register_blueprint(rotas_hospede)
if __name__ == '__main__':
    app.run(debug=True)