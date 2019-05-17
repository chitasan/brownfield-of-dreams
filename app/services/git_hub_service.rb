# frozen_string_literal: true

class GitHubService
  def initialize(token)
    @token = token
  end

  def get_repos
    get_json("user/repos")
  end

  def get_following
    get_json("/user/following")
  end

  def get_followers
    get_json("user/followers")
  end

  private

  def github_conn
    Faraday.new("https://api.github.com/") do |f|
      f.headers["Authorization"] = "token #{@token}"
      f.adapter Faraday.default_adapter
    end
  end

  def get_json(url)
    response = github_conn.get(url)
    data = JSON.parse(response.body, symbolize_names: true)
  end
end
