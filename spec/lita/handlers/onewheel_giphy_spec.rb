require 'spec_helper'

describe Lita::Handlers::OnewheelGiphy, lita_handler: true do

  before(:each) do
    registry.configure do |config|
      config.handlers.onewheel_giphy.api_uri = ''
      config.handlers.onewheel_giphy.api_key = ''
    end
  end

  it { is_expected.to route_command('giphy') }
  it { is_expected.to route_command('gif') }
  it { is_expected.to route_command('gif x') }
  it { is_expected.to route_command('giphy soon') }
  it { is_expected.to route_command('giphytrending') }
  it { is_expected.to route_command('giphytranslate boom') }
  it { is_expected.to route_command('giphysearch boom') }

  it 'gets a giphy by string keywords' do
    mock_fixture('translate_good')
    send_command 'giphy wat'
    expect(replies.last).to eq('https://media1.giphy.com/media/T2NINhwlHgOSk/giphy.gif')
  end

  it 'gets a gif by string keywords' do
    mock_fixture('translate_good')
    send_command 'gif wat'
    expect(replies.last).to eq('https://media1.giphy.com/media/T2NINhwlHgOSk/giphy.gif')
  end

  it 'gets a giphy via search' do
    mock_fixture('search_good')
    send_command 'giphysearch boom'
    expect(replies.last).to eq('http://media2.giphy.com/media/FiGiRei2ICzzG/giphy.gif')
  end

  it 'gets a random giphy' do
    mock_fixture('random_good')
    send_command 'giphy'
    expect(replies.last).to eq('http://s3.amazonaws.com/giphygifs/media/Ggjwvmqktuvf2/giphy.gif')
  end

  it 'gets no trending giphy' do
    mock_fixture('trending_empty')
    send_command 'giphytrending'
    expect(replies.last).to eq(nil)
  end

  it 'gets a trending giphy' do
    mock_fixture('trending_good')
    send_command 'giphytrending'
    expect(replies.last).to eq('http://media0.giphy.com/media/op7uqYWBm3R04/giphy.gif')
  end

  it 'gets a translate giphy' do
    mock_fixture('translate_good')
    send_command 'giphytranslate boom'
    expect(replies.last).to eq('https://media1.giphy.com/media/T2NINhwlHgOSk/giphy.gif')
  end

  def mock_fixture(fixture)
    mock_json = File.open("spec/fixtures/#{fixture}.json").read
    response = double
    allow(response).to receive(:body).and_return(mock_json)
    allow(RestClient).to receive(:get) { response }
  end
end
