from flask import Flask, render_template, request, redirect, url_for

app = Flask(__name__, static_folder='assets', static_url_path='/assets')

from programa.HP_Cliente import *


@app.route('/')
def index():
    return render_template('index.html')


# -------------------------------------------------------------------------------

# HANNA: Clientes, departamento, funcionario, tarifa

# -------------------------------------------------------------------------------

@app.route('/clientes')
def clientes():
    dados = listar("cliente")

    dados_empty = {
        "primeiroNome":"",
        "nomeDoMeio": "",
        "ultimoNome": "",
        "contribuinte": "",
        "CC": "",
        "email": "",
        "telefone":"",
        "dataNascimento": "",
        "ativo": "",
        "genero": "",
    }

    if dados is not None:
        return render_template('clientes.html', dados=dados)
    else:
        return render_template('clientes.html')

@app.route('/criar-cliente', methods=['GET', 'POST'])
def criar_cliente():
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
    inserir("cliente", list(dados.keys()), dados)
    return redirect(url_for('clientes.html'))

 
@app.route('/editar-cliente', methods=['GET', 'POST'])
def editar_cliente():
    dados = {
        "idCliente": request.form["idCliente"],
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
    atualizar("cliente", list(dados.keys()), dados, "idCliente", dados["idCliente"] )
   
    return redirect(url_for('clientes'))

@app.route('/apagar-cliente', methods=['GET', 'POST'])
def apagar_cliente():
   dados = {
        "idCliente": request.form["idCliente"]}
   
   apagar("cliente", "idCliente", dados["idCliente"])
   return redirect(url_for('clientes'))



























if __name__ == '__main__':
    app.run(debug=True)