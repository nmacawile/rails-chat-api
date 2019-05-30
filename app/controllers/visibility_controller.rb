class VisibilityController < ApplicationController
  def update
    current_user.update!(request_params)
    broadcast_visibility
    head :no_content
  rescue
    raise ExceptionHandler::BadRequest
  end
  
  private
  
  def request_params
    params.permit(:visible)
  end
  
  def broadcast_visibility
    ActionCable.server.broadcast(
      'presence',
      { 
        id: current_user.id,
        present: current_user.visible_and_present?
      })
  end
end
