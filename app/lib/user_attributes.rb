class UserAttributes
  def self.json(user)
    return user.slice(:id, :name, :email, :first_name, :last_name, :visible)
  end
end