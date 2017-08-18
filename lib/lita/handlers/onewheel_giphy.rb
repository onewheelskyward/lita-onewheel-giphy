require 'rest-client'

module Lita
  module Handlers
    class OnewheelGiphy < Handler
      config :api_key, required: true
      config :api_uri, required: true
      config :rating, default: nil
      config :limit, default: 25

      route /^giphy$/i,
            :random,
            command: true,
            help: {'giphy' => 'Returns a random Giphy image.  Powered by Giphy!  http://giphy.com'}
      route /^giphy\s+(.+)$/i,
            :translate,
            # :search,
            command: true,
            help: {'giphy [keyword]' => 'Returns a random Giphy image with the specified keyword applied.'}
      route /^giphytrending$/i,
            :trending,
            command: true,
            help: {'giphytrending' => 'Returns a trending Giphy image.'}
      route /^giphytranslate\s+(.+)$/i,
            :translate,
            command: true,
            help: {'giphytranslate' => 'Turns your words into a sweet, sweet Giphy gif.'}

      def search(response)
        keywords = response.matches[0][0]
        Lita.logger.debug "Searching giphy for #{keywords}"
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

      def translate(response)
        keywords = response.matches[0][0]
        uri = get_translate_uri(keywords)
        giphy_data = call_giphy(uri)
        image = get_translate_image(giphy_data.body)
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

      def get_translate_uri(keywords)
        # s - term or phrase to translate into a GIF
        # rating - limit results to those rated (y,g, pg, pg-13 or r).
        # fmt - (optional) return results in html or json format (useful for viewing responses as GIFs to debug/test)
        config.api_uri + 'translate?s=' + URI.encode(keywords) + '&'
      end

      def get_random(data)
        image_data = JSON.parse(data)
        if image_data['data'].count == 0
          Lita.logger.debug 'No images found.'
          return
        end
        image = image_data['data'][get_random_number(image_data['data'].count)]['images']['original']['url']
        Lita.logger.debug "get_random returning #{image}"
        image
      end

      def get_random_number(max)
        and_i = Random.new
        and_i.rand(max)
      end

      def get_image(data)
        image_data = JSON.parse(data)
        image = image_data['data']['image_original_url']
        Lita.logger.debug "get_image returning #{image}"
        image
      end

      def get_translate_image(data)
        image_data = JSON.parse(data)
        image = image_data['data']['images']['original']['url']
        Lita.logger.debug "get_translate_image returning #{image}"
        image
      end

      def call_giphy(uri)
        Lita.logger.debug("Calling giphy with #{uri + 'api_key=' + config.api_key}")
        RestClient.get uri + 'api_key=' + config.api_key
      end

      Lita.register_handler(self)
    end
  end
end
