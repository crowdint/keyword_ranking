$LOAD_PATH << File.expand_path('../../lib' , __FILE__)

require 'rubygems'
require 'bundler'
Bundler.setup(:development)
require 'keyword_ranking'

module KeywordRanking

    describe Ranking do

      describe "#start" do
        it "creates a ranking instance" do
          Ranking.instance.should_not be(nil)
        end 
      end 

    end 

end
