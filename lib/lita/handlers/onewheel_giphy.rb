require 'rest-client'

module Lita
  module Handlers
    class OnewheelGiphy < Handler
      config :api_key, required: true
      config :api_uri, required: true
      config :rating, default: nil
      config :limit, default: 25

      route /^giphy$/, :random, command: true
      route /^giphy\s+(.*)$/, :search, command: true
      route /^giphytrending$/, :trending, command: true

      def search(response)
        keywords = response.matches[0][0]
        uri = get_search_uri(keywords)
        giphy_data = call_giphy(uri)
        image = get_random(giphy_data.body)
        response.reply image
      end

      def random(response)
        uri = get_random_uri
        giphy_data = call_giphy(uri)
        image = get_image(giphy_data.body)
        response.reply image
      end

      def trending(response)
        uri = get_trending_uri
        giphy_data = call_giphy(uri)
        image = get_random(giphy_data.body)
        response.reply image
      end

      def get_search_uri(keywords)
        # q - search query term or phrase
        # limit - (optional) number of results to return, maximum 100. Default 25.
        # offset - (optional) results offset, defaults to 0.
        # rating - limit results to those rated (y,g, pg, pg-13 or r).
        # fmt - (optional) return results in html or json format (useful for viewing responses as GIFs to debug/test)
        config.api_uri + 'search?q=' + URI.encode(keywords) + '&'
      end

      def get_random_uri()
        # tag - the GIF tag to limit randomness by
        # rating - limit results to those rated (y,g, pg, pg-13 or r).
        # fmt - (optional) return results in html or json format (useful for viewing responses as GIFs to debug/test)
        config.api_uri + 'random?' #?q=' + URI.encode(keywords)
      end

      def get_trending_uri()
        # limit (optional) limits the number of results returned. By default returns 25 results.
        # rating - limit results to those rated (y,g, pg, pg-13 or r).
        # fmt - (optional) return results in html or json format (useful for viewing responses as GIFs to debug/test)
        config.api_uri + 'trending?'
      end

      def get_random(data)
        image_data = JSON.parse(data)
        image_data['data'][get_random_number(image_data['data'].count)]['images']['original']['url']
      end

      def get_random_number(max)
        and_i = Random.new
        so_far_away = and_i.rand(max)
        puts "rand: #{so_far_away}"
        so_far_away
      end

      def get_image(data)
        image_data = JSON.parse(data)
        image_data['data']['image_original_url']
      end

      def call_giphy(uri)
        Lita.logger.debug("Calling giphy with #{uri}")
        RestClient.get uri + 'api_key=' + config.api_key
      end

      Lita.register_handler(self)
    end
  end
end
