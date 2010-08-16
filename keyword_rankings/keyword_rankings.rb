# :offset => page number
# BING REAL LIMIT = 1000 pages of 10 results
# GOOGLE REAL LIMIT = 56 pages of ~ 63 results
# YAHOO REAL LIMIT = 100 results

module KeywordRankings
  RES_LIMIT = 200
  RES_PER_PAGE = 10 #careful, it doesn't work with more than 10 for all search engines!

  def get_ranking(*args) # keyword, url, engine, limit
    options = args.extract_options!
    limit = options[:limit].present? ? options[:limit].to_i : RES_LIMIT
    site_uri = options[:url].gsub(/(http:\/\/|https:\/\/)/, '').gsub(/^www/, '')
    validate_arguments options
    find_ranking(options[:keyword], site_uri, limit, options[:engine])
  end

  def validate_arguments(options)
    raise "Keyword and site parameters must be Strings" unless options[:keyword].present? and options[:keyword].is_a?(String) and options[:url].present? and options[:url].is_a?(String)
    raise "Limit of #{RES_LIMIT} results at most" if options[:limit] > RES_LIMIT
    raise "Engine should be 'bing', 'google' or 'yahoo'" unless options[:engine].present? and [:bing, :google, :yahoo].include?(options[:engine].to_sym)
  end

  def find_ranking(keyword, site, limit, engine)
    request_url, results_container, cite_container = case engine.to_sym
    when :bing
      ["http://www.bing.com/search?q=#{keyword}&count=#{RES_PER_PAGE}&first=", '#wg0 > li', 'cite']
    when :google
      ["http://www.google.com/search?q=#{keyword}&num=#{RES_PER_PAGE}&start=", '#ires > ol > li', 'cite']
    when :yahoo
      ["http://search.yahoo.com/search?p=#{keyword}&n=#{RES_PER_PAGE}&b=", '#web > ol > li', 'span']
    end
    count, rank = 0, nil
    loop {
      results = Nokogiri.parse(%x{ curl -A Mozilla "#{request_url}#{count}" }).css(results_container)
      rank = results.index(results.detect{ |result| result.css(cite_container).text.match Regexp.new(site) })
      if count > RES_LIMIT
        break
      elsif rank.present?
        rank = count + rank
        break
      end
      count += RES_PER_PAGE
    }
    rank.try(:next)
  end

end

