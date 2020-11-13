class DadosVenda
  include Mongoid::Document
  include Mongoid::Timestamps
  field :codigoCliente, type: Integer
  field :nomeCliente, type: String
  field :cpfCnpjCliente, type: String
  field :enderecoCliente, type: String
  field :codigoEmpresa, type: Integer
  field :cnpjEmpresa, type: String
  field :codigoProduto, type: Integer
  field :nomeProduto, type: String
  field :precoVenda, type: BigDecimal
  field :valorUnitario, type: BigDecimal
  field :quantidade, type: BigDecimal
  field :totalVenda, type: BigDecimal
  field :totalMercado, type: BigDecimal
  field :totalDesconto, type: BigDecimal
  field :codigoVenda, type: Integer
  field :codigoItemVenda, type: Integer
  field :dataVenda, type: DateTime
  field :codigoAcionista, type: Integer

  def self.update_or_create(attributes)
    obj = assign_or_new(attributes)
    obj.save!
    obj
  end

  def self.assign_or_new(attributes)
    obj = first || new
    obj.assign_attributes(attributes)
    obj
  end
end
