from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')

rotas_reservaQuarto = Blueprint("rotas_reservaQuarto", __name__)



@rotas_reservaQuarto.route('/reserva-quartos')
def listar_reserva_quartos():
    dados = conn.select_data("reserva_quarto")
    action = "pesquisar-reserva_quarto"
    if dados is not None:
        return render_template('reserva_quartos.html', dados=dados, action = action)
    else:
        return render_template('reserva_quartos.html')
    
    

@rotas_reservaQuarto.route('/criar-reserva-quarto', methods=['GET', 'POST'])
def criar_reserva_quarto():
    dados = {
        "primeiroNome": request.form["primeiroNome"],
        "nomeDoMeio": request.form["nomeDoMeio"],
        "ultimoNome": request.form["ultimoNome"],
        "contribuinte": request.form["contribuinte"],
        "CC": request.form["CC"],
        "email": request.form["email"],
        "telefone": request.form["telefone"],
        "dataNascimento": request.form["dataNascimento"],
        "ativo": request.form["ativo"],
        "genero": request.form["genero"],
    }
    conn.insert_data("reserva_quarto", dados)
    return redirect(url_for('rotas_reserva_quarto.listar_reserva_quartos'))

@rotas_reservaQuarto.route('/editar-reserva-quarto', methods=['GET', 'POST'])
def editar_reserva_quarto():
    idreserva_quarto = {"idreserva_quarto": request.form["idreserva_quarto"]}
    dados = {
        "primeiroNome": request.form["primeiroNome"],
        "nomeDoMeio": request.form["nomeDoMeio"],
        "ultimoNome": request.form["ultimoNome"],
        "contribuinte": request.form["contribuinte"],
        "CC": request.form["CC"],
        "email": request.form["email"],
        "telefone": request.form["telefone"],
        "dataNascimento": request.form["dataNascimento"],
        "ativo": request.form["ativo"],
        "genero": request.form["genero"],
    }
    conn.update_data("reserva_quarto", dados, idreserva_quarto)
    return redirect(url_for('rotas_reserva_quarto.listar_reserva_quartos'))



@rotas_reservaQuarto.route('/apagar-reserva-quarto', methods=['GET', 'POST'])
def apagar_reserva_quarto():
    idreserva_quarto = {"idreserva_quarto": request.form["idreserva_quarto"]}
    conn.delete_data("reserva_quarto", idreserva_quarto)
    return redirect(url_for('rotas_reserva_quarto.listar_reserva_quartos'))



@rotas_reservaQuarto.route('/pesquisar-reserva-quarto', methods=['GET', 'POST'])
def pesquisar_reserva_quarto():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="reserva_quarto", search= param)

    print("dados") 
    if dados:
     return render_template('pesquisa.html', dados = dados)
    else:
     return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])







app.register_blueprint(rotas_reservaQuarto)
if __name__ == '__main__':
    app.run(debug=True)