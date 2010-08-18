require File.expand_path(File.dirname(__FILE__) + '/spec_helper')

# describe "KeywordRanking" do
#   it "fails" do
#     fail "hey buddy, you should probably rename this file and start specing for real"
#   end
# end
# 
# 
# # $LOAD_PATH << File.expand_path('../../lib' , __FILE__)
# # 
# # require 'rubygems'
# # require 'bundler'
# # Bundler.setup(:development)
# # require 'keyword_ranking'

module FinderSpecHelper
  class Finder
    def find(keyword, site, limit, engine)
      0
    end
  end
end

module KeywordRanking

    describe Ranking do

      let (:options) { {:keyword => 'agile', :url => 'www.crowdint.com', :engine => 'google', :limit => 20} }
      let(:ranking) { Ranking.new(FinderSpecHelper::Finder.new) }

      context '#get ranking fails' do

        it 'without parameters' do
          lambda { ranking.get }.should raise_exception
        end

        it 'with unsupported engine' do
          lambda { ranking.get(options.merge({:engine => 'mugle'})) }.should raise_exception
        end 

        it 'exceeding results limit' do
          lambda { ranking.get(options.merge({:limit => 201})) }.should raise_exception
        end 

        it 'with bad keyword and url data types' do
          lambda { ranking.get(options.merge({:keyword  => 1000, :url => 1.2})) }.should raise_exception
        end 

        it 'using malformed URLs'

      end 

      context '#get ranking success' do

        it 'with correct parameters on google' do
          ranking.get(options).should equal 0
        end

        it 'with correct parameters on yahoo'

        it 'with correct parameters on bing'

        it 'should support multiple keywords'

        it 'should support a symbol as an engine name'

      end

    end 

end
