#ok

from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_funcionario = Blueprint("rotas_funcionario", __name__)


@rotas_funcionario.route('/funcionarios')
def listar_funcionarios():
    dados = conn.select_data("funcionario")
    action = "pesquisar-funcionario"
    if dados is not None:
        return render_template('funcionarios.html', dados=dados, action = action)
    else:
        return render_template('funcionarios.html')
    

    

@rotas_funcionario.route('/criar-funcionario', methods=['GET', 'POST'])
def criar_funcionario():
    dados = {
        "primeiroNome": request.form["primeiroNome"],
        "nomeDoMeio": request.form["nomeDoMeio"],
        "ultimoNome": request.form["ultimoNome"],
        "contribuinte": request.form["contribuinte"],
        "CC": request.form["CC"],
        "email": request.form["email"],
        "telefone": request.form["telefone"],
        "dataNascimento": request.form["dataNascimento"],
        "status": request.form["status"],
        "genero": request.form["genero"],
    }
    conn.insert_data("funcionario", dados)
    return redirect(url_for('rotas_funcionario.listar_funcionarios'))

@rotas_funcionario.route('/editar-funcionario', methods=['GET', 'POST'])
def editar_funcionario():
    idfuncionario = {"idfuncionario": request.form["idfuncionario"]}
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
    conn.update_data("funcionario", dados, idfuncionario)
    return redirect(url_for('rotas_funcionario.listar_funcionarios'))



@rotas_funcionario.route('/apagar-funcionario', methods=['GET', 'POST'])
def apagar_funcionario():
    idfuncionario = {"idfuncionario": request.form["idfuncionario"]}
    conn.delete_data("funcionario", idfuncionario)
    return redirect(url_for('rotas_funcionario.listar_funcionarios'))



@rotas_funcionario.route('/pesquisar-funcionario', methods=['GET', 'POST'])
def pesquisar_funcionario():
    param = request.form["param"]

    dados = conn.select_data(table="funcionario", search= param)

    if dados:
         return render_template('pesquisa.html', dados = dados)
    else:
        return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])



@rotas_funcionario.route('/teste')
def teste():
   
    dados =  conn.select_data(table="funcionario", search= "hanna")

    print("dados") 
    if dados:
     return render_template('pesquisa.html', dados = dados)
    else:
     return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])






app.register_blueprint(rotas_funcionario)
if __name__ == '__main__':
    app.run(debug=True)