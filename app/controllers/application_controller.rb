class ApplicationController < ActionController::API
  Mongo::Logger.logger.level = Logger::WARN
  require 'digest'

  def authenticate_with_secret_code!
    render json: { errors: 'Unauthorized access!'}, status: 401 unless secret_code_valid?
  end

  def secret_code_valid?
    return false if request.headers['Authorization'].nil? || request.headers['cnpj'].nil?

    time = Time.new

    # code = (Time.now.year.eql? 2021) ?
    #            time.strftime("%HiBolsa2021" + request.headers['cnpj'] + "%mSA%-d") :
    code = time.strftime("%HiBolsa%Y" + request.headers['cnpj'] + "%mSA%-d")

    request.headers['Authorization'] == Digest::SHA256.hexdigest(code)
  end

end
