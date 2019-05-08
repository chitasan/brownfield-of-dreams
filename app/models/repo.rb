class Repo
  attr_reader :name,
                    :link

  def initialize(data)
    @name = data["name"]
    @link = data["html_url"]
  end

end
