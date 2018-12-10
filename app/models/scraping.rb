class Scraping
  def self.movie_urls

    links = []
    agent = Mechanize.new

    next_url = ""
    num = 1
    while true do
      current_page = agent.get("http://review-movie.herokuapp.com/"+next_url)
      elements = current_page.search('.entry-title a')
      elements.each do |ele|
        links << ele.get_attribute('href')
      end
      puts num
      num+=1
      next_link = current_page.at('.pagination .next a')
      break unless next_link
    #そのタグからhref属性の値を取得
      next_url = next_link.get_attribute('href')

    end
    links.each do |link|
      get_product('http://review-movie.herokuapp.com/'+link)
    end
  end

  def self.get_product(link)
    agent = Mechanize.new
    page = agent.get(link)
    title = page.at('.entry-title').inner_text
    image_url = page.at('.entry-content img')[:src] if page.at('.entry-content img')

    product = Product.where(title: title, image_url: image_url).first_or_initialize
    product.director = page.at('.director span').inner_text if page.at('.director span')
    product.detail = page.at('.entry-content p').inner_text if page.at('.entry-content p').inner_text
    product.open_date = page.at('.review_details .date span').inner_text if page.at('.review_details .date span').inner_text
    product.save
  end
end
