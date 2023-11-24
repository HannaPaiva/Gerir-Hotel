from flask import Flask, render_template, request, redirect

app = Flask(__name__, static_folder='assets', static_url_path='/assets')

from programa.HP_Cliente import *


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/clientes')
def clientes():
      
    dados = listar("cliente")
    return render_template('clientes.html', dados=dados)
 
 

@app.route('/criar_cliente')
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

    return render_template('/cliente.html')

if __name__ == '__main__':
    app.run(debug=True)