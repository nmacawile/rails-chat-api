class QueryUsers
  def initialize(query)
    @query = query
  end
  
  def call
    return User.all if @query.blank?
    User.where(
      "CONCAT_WS(' ', first_name, last_name, first_name) ILIKE ?", 
      "%#{@query.squish}%")
  end
end