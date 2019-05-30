class TokenValidationController < ApplicationController
  def validate
    json_response(UserAttributes.json(current_user))
  end
end
