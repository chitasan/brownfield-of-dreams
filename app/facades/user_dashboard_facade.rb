# frozen_string_literal: true

class UserDashboardFacade
  def initialize(current_user)
    @current_user = current_user
  end

  def header
    "#{repos_top_five.count} Repos"
  end

  def repos_top_five
    top_repos = repos_data.map do |repo_data|
      Repo.new(repo_data)
    end
    top_repos.first(5)
  end

  def following
    following_data.map do |data|
      Following.new(data)
    end
  end

  def followers
    followers_data.map do |follower_data|
      Follower.new(follower_data)
    end
  end

  private

  def repos_data
    @repos_data ||= service.repos
  end

  def following_data
    @following_data ||= service.following
  end

  def followers_data
    @followers_data ||= service.followers
  end

  def service
    @service ||= GitHubService.new(@current_user.token)
  end
end
