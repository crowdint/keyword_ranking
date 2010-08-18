require 'nokogiri'
require 'net/http'

class Array
  def extract_options!
    last.is_a?(::Hash) ? pop : {}
  end
end

module KeywordRanking

  RES_LIMIT = 200
  RES_PER_PAGE = 10 #careful, it doesn't work with more than 10 for all search engines!

  class Ranking

    def initialize(finder = Finder.new)
      @finder = finder
    end

    def get(*args) # keyword, url, engine, limit
      options = args.extract_options!
      limit = options[:limit] ? options[:limit].to_i : RES_LIMIT
      site_uri = options[:url].gsub(/(http:\/\/|https:\/\/)/, '').gsub(/^www/, '')
      validate_arguments options
      @finder.find(options[:keyword], site_uri, limit, options[:engine])
    end

    protected
    def validate_arguments(options)
      raise "Keyword and site parameters must be Strings" unless options[:keyword].is_a?(String) and options[:url].is_a?(String)
      raise "Limit of #{RES_LIMIT} results at most" if options[:limit] > RES_LIMIT
      raise "Engine should be 'bing', 'google' or 'yahoo'" unless [:bing, :google, :yahoo].include?(options[:engine].to_sym)
    end

  end

  class Finder

    def find(keyword, site, limit, engine)
      request_url, results_selector, cite_selector = case engine.to_sym
      when :bing
        ["http://www.bing.com/search?q=#{keyword}&count=#{RES_PER_PAGE}&first=", '#wg0 > li', 'cite']
      when :google
        ["http://www.google.com/search?q=#{keyword}&num=#{RES_PER_PAGE}&start=", '#ires > ol > li', 'cite']
      when :yahoo
        ["http://search.yahoo.com/search?p=#{keyword}&n=#{RES_PER_PAGE}&b=", '#web > ol > li', 'span']
      end

      count, rank = 0, nil

      loop {
        html_response = Net::HTTP.get_response(URI.parse("#{request_url}#{count}")).body
        html_results = Nokogiri.parse(html_response).css(results_selector)
        rank = html_results.index(html_results.detect{ |result| result.css(cite_selector).text.match Regexp.new(site) })

        if count > limit
          break
        elsif rank
          rank += count
          break
        end
        count += RES_PER_PAGE
      }

      rank ? rank.next : nil

     end

  end

end
