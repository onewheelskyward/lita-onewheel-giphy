require 'spec_helper'

describe Lita::Handlers::OnewheelGiphy, lita_handler: true do

  before(:each) do
    registry.configure do |config|
      config.handlers.onewheel_giphy.api_uri = ''
      config.handlers.onewheel_giphy.api_key = ''
    end
  end

  it { is_expected.to route_command('giphy') }

  it 'gets a giphy by string keywords' do
    mock_fixture('search_good')
    send_command 'giphy wat'
    expect(replies.last).to eq('http://media2.giphy.com/media/FiGiRei2ICzzG/giphy.gif')
  end

  it 'gets a random giphy' do
    mock_fixture('search_good')
    send_command 'giphy'
    expect(replies.last).to eq('http://media2.giphy.com/media/FiGiRei2ICzzG/giphy.gif')
  end

  def mock_fixture(fixture)
    mock_json = File.open("spec/fixtures/#{fixture}.json").read
    response = double
    allow(response).to receive(:body).and_return(mock_json)
    allow(RestClient).to receive(:get) { response }
  end
end
