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

  def friends
    # binding.pry
    conn = Faraday.new(ENV["FRIENDSHIP_SITE"])
    response = conn.get("api/v1/friendships?initiator_id=#{@current_user.uid}")
    results = JSON.parse(response.body)
    results.map do |user_id|
      User.find_by_uid(user_id)
    end
  end

  def in_database(follower)
    in_db = followers_data.map do |follower|
      User.find_by_uid(follower[:id])
    end
    if follower.uid
      # "#{link_to} Add Friend, /friendships?initiator_id=#{@current_user.uid}&#{follower.uid}, method: post"
      # <%= <a href="/friendships?initiator_id=#{@current_user.uid}&#{follower.uid}"> Add Friend </a> %>
       "/friendships?initiator_id=#{@current_user.uid}&recipient_id=#{follower.uid}"
    end
  end


  private
    def repos_data
      @_repos_data ||= service.get_repos
    end

    def following_data
      @_following_data ||= service.get_following
    end

    def followers_data
      @_followers_data ||= service.get_followers
    end

    def service
      @_service ||= GitHubService.new(@current_user.token)
    end
end
