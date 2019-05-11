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

  private
    def github_conn
      conn = Faraday.new("https://api.github.com/") do |f|
        f.headers["Authorization"] = "token #{@token}"
        # f.params["access_token"] = @token
        f.adapter Faraday.default_adapter
      end
    end

    def get_json(url)
      response = github_conn.get(url)
      data = JSON.parse(response.body, symbolize_names: true)
    end

end
