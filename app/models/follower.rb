# frozen_string_literal: true

class Follower
  attr_reader :handle, :link

  def initialize(data)
    @handle = data[:login]
    @link = data[:html_url]
  end
end
