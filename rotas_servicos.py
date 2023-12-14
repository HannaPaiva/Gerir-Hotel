from flask import Flask, render_template, request, redirect, url_for, Blueprint
from programa.z_database_manager import DatabaseManager

conn = DatabaseManager(host="127.0.0.1", user="root", password="", database="hotel", port=3306)

app = Flask(__name__, static_folder='assets', static_url_path='/assets')
rotas_servico = Blueprint("rotas_servico", __name__)


@rotas_servico.route('/servicos')
def listar_servicos():
    dados = conn.select_data("servico")
    if dados is not None:
        return render_template('servico.html', dados=dados)
    else:
        return render_template('servico.html')

@rotas_servico.route('/criar-servico', methods=['GET','POST'])
def criar_servico():
    dados = {
        "nomeServico": request.form.get("nomeServico"),
        "preco": request.form.get("preco"),
        "descricao": request.form.get("descricao"),
        "idDepartamento": request.form.get("idDepartamento")
    }
    conn.insert_data("servico", dados)
    return redirect(url_for('rotas_servico.listar_servicos'))


@rotas_servico.route('/editar-servico', methods=['POST'])
def editar_servico():
    idServico = {"idServico": request.form.get("idServico")}
    dados = {
        "nomeServico": request.form.get("nomeServico"),
        "preco": request.form.get("preco"),
        "descricao": request.form.get("descricao"),
        "idDepartamento": request.form.get("idDepartamento")
    }
    conn.update_data("servico", dados, idServico)
    return redirect(url_for('rotas_servico.listar_servicos'))



@rotas_servico.route('/apagar-servico', methods=['GET', 'POST'])
def apagar_servico():
    idServico = {"idServico": request.form["idServico"]}
    conn.delete_data("servico", idServico)
    return redirect(url_for('rotas_servico.listar_servicos'))

@rotas_servico.route('/pesquisar-servico', methods=['GET', 'POST'])
def pesquisar_servico():
    param = request.form["param"]
    # colls = request.form["colls"]
    dados =  conn.select_data(table="servico", search= param)

    return render_template('pesquisa.html', dados = dados)

app.register_blueprint(rotas_servico)
if __name__ == '__main__':
    app.run(debug=True)