class ApplicationController < ActionController::Base
  protect_from_forgery

  def current_user
    access_token = request.headers['Authorization']
    if access_token =~ /\s/
      access_token = access_token.split(' ').last
    end
    if access_token.present?
      # @current_user ||= Rails.cache.fetch(access_token, expires_in: 12.hours) do
	    #   headers = { "Authorization" => "Bearer #{access_token}", "Content-Type" => 'application/json' }
      #   data = HTTParty.get(Rails.application.credentials.send(Rails.env)[:wso2_url] + '/oauth2/userinfo', headers: headers, :verify => false)
      #   response = JSON.parse(data.response.body)
      #   if response['email'].present?
      #     Employee.where(email: response['email']).first
      #   end
      # end
      @current_user = User.last
    end
  end
end
