require 'rails_helper'

RSpec.describe 'YoutubeService' do
  it 'exists' do
    service = YoutubeService.new

    expect(service).to be_a YoutubeService
  end
  describe 'instance_methods' do
    it 'can get video info by id' do
      VCR.use_cassette('youtube/v3/videos') do
        service = YoutubeService.new
        id="J7ikFUlkP_k"
        video_info = service.video_info(id)
        expect(video_info[:items][0]).to have_key(:snippet)
        expect(video_info[:items][0]).to have_key(:statistics)
        expect(video_info[:items][0]).to have_key(:contentDetails)
      end
    end
  end
end
