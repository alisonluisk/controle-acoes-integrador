class ApiVersionConstraint

  def initialize(options)
    @version = options[:version]
    @default = options[:default]
  end

  def matches?(req)
    req.headers['Accept'] = '*/*' unless req.headers['Accept'].present?
    @default || req.headers['Accept'].include?("application/vnd.integradorIbolsa.v#{@version}")
  end
end