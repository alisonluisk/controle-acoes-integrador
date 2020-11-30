class Api::V1::DadosVendaController < ApplicationController
  before_action :authenticate_with_secret_code!, only:[:create, :index]

  def index
    dados = DadosVenda.all
    render json: dados, status: 200
  end

  def create
    json = JSON.parse params["dadosVenda"]
    # json = params[:dadosVenda]
    # params.permit!
    begin
      venda = DadosVenda.where(codigoItemVenda: json["codigoItemVenda"], codigoVenda: json["codigoVenda"], codigoEmpresa: json["codigoEmpresa"])
          .update_or_create(json)

      acionista = Acionista.where(cpf_cnpj: venda.cpfCnpjCliente).first
      venda.update(codigoAcionista: acionista.id) if acionista.present?

      render :nothing => true, status: 201
    rescue => ex
      ErroIntegracao.create(  cpfCnpjCliente: json["cpfCnpjCliente"], codigoProduto: json["codigoProduto"],
                              codigoVenda: json["codigoVenda"], codigoItemVenda: json["codigoItemVenda"],
                              erroIntegracao: ex.inspect)
      puts ex
      render :nothing => true, status: 500
    end
  end

  def cancelar
    json = JSON.parse params["dadosVenda"]
    # json = params[:dadosVenda]
    # params.permit!
    begin
      venda = DadosVenda.where(codigoItemVenda: json["codigoItemVenda"], codigoVenda: json["codigoVenda"], codigoEmpresa: json["codigoEmpresa"])
                  .destroy_all
      render :nothing => true, status: 200
    rescue => ex
      ErroIntegracao.create(  codigoVenda: json["codigoVenda"], codigoItemVenda: json["codigoItemVenda"],
                              erroIntegracao: ex.inspect)
      puts ex
      render :nothing => true, status: 500
    end
  end
end
