# frozen_string_literal: true

class GitHubService
  def initialize(token)
    @token = token
  end

  def repos
    get_json("user/repos")
  end

  def following
    get_json("/user/following")
  end

  def followers
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
    JSON.parse(response.body, symbolize_names: true)
  end
end
