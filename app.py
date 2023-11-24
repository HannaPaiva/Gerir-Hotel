from flask import Flask, render_template

app = Flask(__name__, static_folder='assets', static_url_path='/assets')

from programa.HP_Cliente import *


@app.route('/')
def index():
    return render_template('index.html')


@app.route('/clientes')
def clientes():
      
    dados = listar("cliente")
    return render_template('clientes.html', dados=dados)
 

@app.route('/admin/')
def admin():
      
    nome = {"name": "Axel", "age": 10 }
    return render_template('/admin/index.html', mario=nome)
 

@app.route('/admin/clientes')
def admin_clientes():
      
    nome = {"name": "Axel", "age": 10 }
    return render_template('/admin/index.html', mario=nome)
 

@app.route('/ok')
def ok():
      
    nome = {"name": "Axel", "age": 10 }
    return render_template('/index.html', mario=nome)


@app.route('/servicos')
def servicos():
      
    nome = {"name": "Axel", "age": 10 }
    return render_template('/servicos.html', mario=nome)




if __name__ == '__main__':
    app.run(debug=True)