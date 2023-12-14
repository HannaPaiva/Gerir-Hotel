from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager
conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)
app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_departamento = Blueprint("rotas_departamento", __name__)


@rotas_departamento.route('/departamentos')
def listar_departamentos():
    dados = conn.select_data("departamento")
    action = "pesquisar-departamento"
    if dados is not None:
        return render_template('departamentos.html', dados=dados, action = action)
    else:
        return render_template('departamentos.html')
    


@rotas_departamento.route('/criar-departamento', methods=['GET', 'POST'])
def criar_departamento():
    dados = {
        "idChefe": request.form["idChefe"],
        "nomeDepartamento": request.form["nomeDepartamento"],
        "descricao": request.form["descricao"],
    }
    conn.insert_data("departamento", dados)
    return redirect(url_for('rotas_departamento.listar_departamentos'))

@rotas_departamento.route('/editar-departamento', methods=['GET', 'POST'])
def editar_departamento():
    iddepartamento = {"iddepartamento": request.form["iddepartamento"]}

    dados = {
        "idChefe": request.form["idChefe"],
        "nomeDepartamento": request.form["nomeDepartamento"],
        "descricao": request.form["descricao"]
    }

    conn.update_data("departamento", dados, iddepartamento)
    return redirect(url_for('rotas_departamento.listar_departamentos'))



@rotas_departamento.route('/apagar-departamento', methods=['GET', 'POST'])
def apagar_departamento():
    iddepartamento = {"iddepartamento": request.form["iddepartamento"]}
    conn.delete_data("departamento", iddepartamento)
    return redirect(url_for('rotas_departamento.listar_departamentos'))



@rotas_departamento.route('/pesquisar-departamento', methods=['GET', 'POST'])
def pesquisar_departamento():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="departamento", search= param)

    if dados:
     return render_template('pesquisa.html', dados = dados)
    else:
     return render_template('pesquisa.html', dados = [{"response":"Não encontrado" }])




app.register_blueprint(rotas_departamento)
if __name__ == '__main__':
    app.run(debug=True)