class Following
  attr_reader :link

  def initialize(data)
    @data = data[:link]
  end
end
