#Keyword Ranking

Use this gem to calculate the keyword ranking for *Bing*, *Yahoo* or *Google* as follows:

KeywordRanking::Ranking.new(:keyword => 'one keyword', :url => 'www.mydomain.com', :limit => 100).from_google

##Note

* Only *:keyword* and *:url* are required
* You can search -->  *.from_google*,  *.from_yahoo*,  *.from_bing*
* *:limit* by default is 200
* You can change the results per page value changing *:res_per_page* having in mind that not all the 3 engines support more than 10 results per page with this utility

More updates coming

##TODO

* Improve Testing Code

