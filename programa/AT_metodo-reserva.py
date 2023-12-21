from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_metodo = Blueprint("rotas_metodo", __name__)


@rotas_metodo.route('/metodos')
def listar_metodos():
    dados = conn.select_data("metodoreserva")
    action = "pesquisar-metodo"
    if dados is not None:
        return render_template('metodos.html', dados=dados, action = action)
    else:
        return render_template('metodos.html')
    
@rotas_metodo.route('/criar-metodo', methods=['GET', 'POST'])
def criar_metodo():
    dados = {
        "nomemetodo": request.form["nomemetodo"],
    }
    conn.insert_data("metodoreserva", dados)
    return redirect(url_for('rotas_metodo.listar_metodos'))

@rotas_metodo.route('/editar-metodo', methods=['GET', 'POST'])
def editar_metodo():
    idmetodo = {"idmetodo": request.form["idmetodo"]}
    dados = {
        "nomemetodo": request.form["nomemetodo"],
    }
    conn.update_data("metodoreserva", dados, idmetodo)
    return redirect(url_for('rotas_metodo.listar_metodos'))

@rotas_metodo.route('/apagar-metodo', methods=['GET', 'POST'])
def apagar_metodo():
    idmetodo = {"idmetodo": request.form["idmetodo"]}
    conn.delete_data("metodoreserva", idmetodo)
    return redirect(url_for('rotas_metodo.listar_metodos'))

@rotas_metodo.route('/pesquisar-metodo', methods=['GET', 'POST'])
def pesquisar_metodo():
    param = request.form["param"]
    dados =  conn.select_data(table="metodoreserva", search= param)

    print("dados") 
    if dados:
        return render_template('pesquisa.html', dados = dados)
    else:
        return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])

app.register_blueprint(rotas_metodo)
if __name__ == '__main__':
    app.run(debug=True)