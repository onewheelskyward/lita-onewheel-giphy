require 'pry'

module Lita
  module Handlers
    class OnewheelGiphy < Handler
      config :api_key, required: true
      config :api_uri, required: true
      config :rating, default: nil
      config :limit, default: 25

      route /^giphy\s+(.*)$/, :search, command: true

      def search(response)
        keywords = response.matches[0][0]
        uri = get_search_uri(keywords)
        giphy_data = call_giphy(uri)
        image = get_first(giphy_data.body)
        response.reply image
      end

      def get_search_uri(keywords)
        # q - search query term or phrase
        # limit - (optional) number of results to return, maximum 100. Default 25.
        # offset - (optional) results offset, defaults to 0.
        # rating - limit results to those rated (y,g, pg, pg-13 or r).
        # fmt - (optional) return results in html or json format (useful for viewing responses as GIFs to debug/test)
        config.api_uri + 'search?q=' + URI.encode(keywords)
      end

      def get_first(data)
        image_data = JSON.parse(data)
        puts image_data.inspect
        image_data['data'][0]['images']['original']['url']
      end

      def call_giphy(uri)
        RestClient.get uri
      end

      Lita.register_handler(self)
    end
  end
end
