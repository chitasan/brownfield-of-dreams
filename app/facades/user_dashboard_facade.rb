class UserDashboardFacade
  def initialize(current_user)
    @current_user  = current_user
  end
def repos
  conn = Faraday.new("https://api.github.com/user/repos") do |f|
    f.headers["Authorization"] = @current_user.token
    f.adapter Faraday.default_adapter
  end

  response = conn.get
  data = JSON.parse(response.body, symbolize_names: true).first(5)

  data.map do |repo_data|
    Repo.new(repo_data)
  end
end

end
