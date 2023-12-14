from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_reservaquarto = Blueprint("rotas_reservaquarto", __name__)


@rotas_reservaquarto.route('/reservaquartos')
def listar_reservaquartos():
    dados = conn.select_data("reservaquarto")
    action = "pesquisar-reservaquarto"
    if dados is not None:
        return render_template('reservaquartos.html', dados=dados, action = action)
    else:
        return render_template('reservaquartos.html')
    
@rotas_reservaquarto.route('/criar-reservaquarto', methods=['GET', 'POST'])
def criar_reservaquarto():
    dados = {
        "numquarto": request.form["numquarto"],
        "idreserva": request.form["idreserva"],
        "observacoes": request.form["observacoes"]
    }
    conn.insert_data("reservaquarto", dados)
    return redirect(url_for('rotas_reservaquarto.listar_reservaquartos'))

@rotas_reservaquarto.route('/editar-reservaquarto', methods=['GET', 'POST'])
def editar_reservaquarto():
    idreservaquarto = {"idreservaquarto": request.form["idreservaquarto"]}
    dados = {
        "numquarto": request.form["numquarto"],
        "idreserva": request.form["idreserva"],
        "observacoes": request.form["observacoes"]
    }
    conn.update_data("reservaquarto", dados, idreservaquarto)
    return redirect(url_for('rotas_reservaquarto.listar_reservaquartos'))

@rotas_reservaquarto.route('/apagar-reservaquarto', methods=['GET', 'POST'])
def apagar_reservaquarto():
    idreservaquarto = {"idreservaquarto": request.form["idreservaquarto"]}
    conn.delete_data("reservaquarto", idreservaquarto)
    return redirect(url_for('rotas_reservaquarto.listar_reservaquartos'))

@rotas_reservaquarto.route('/pesquisar-reservaquarto', methods=['GET', 'POST'])
def pesquisar_reservaquarto():
    param = request.form["param"]
    dados =  conn.select_data(table="reservaquarto", search= param)

    print("dados") 
    if dados:
        return render_template('pesquisa.html', dados = dados)
    else:
        return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])

app.register_blueprint(rotas_reservaquarto)
if __name__ == '__main__':
    app.run(debug=True)