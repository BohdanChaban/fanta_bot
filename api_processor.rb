require 'rest-client'
require 'json'

class ApiProcessor
  HOST = 'http://fanta.yurikuzhiy.net/api/'.freeze

  def initialize(action)
    @action = action
  end

  def call
    JSON.parse(request.body)
  end

  private

  def request
    RestClient.get(request_path)
  end

  def request_path
    "#{HOST}#{@action}"
  end
end
