class ErroIntegracao
  include Mongoid::Document
  include Mongoid::Timestamps
  field :cpfCnpjCliente, type: String
  field :codigoProduto, type: Integer
  field :codigoVenda, type: Integer
  field :codigoItemVenda, type: Integer
  field :erroIntegracao, type: String

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
