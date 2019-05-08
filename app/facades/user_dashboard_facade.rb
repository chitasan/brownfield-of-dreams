class UserDashboardFacade
  def initialize(current_user)
    @current_user  = current_user
  end

  def header
    "#{repos_top_five.count} Repos"
  end

  def repos_top_five
    repos_data.map do |repo_data|
      Repo.new(repo_data)
    end.first(5)
  end

  private
    def repos_data
      @_repos_data ||= service.get_repos
    end

    def service
      @_service ||= GitHubService.new(@current_user.token)
    end
end
