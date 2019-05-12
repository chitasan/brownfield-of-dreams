
class Following
  attr_reader :link, :handle

   def initialize(data)
    @link = data[:html_url]
    @handle = data[:login]
  end
end