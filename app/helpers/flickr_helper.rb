module FlickrHelper
  def user_photos(user_id, license, sort, safe_search, photo_count)
    flickr.photos.search(:text => user_id, :license => license, :sort => sort, :safe_search => safe_search, :per_page => 60, :page => 1).first(photo_count)
  end

  def user_photo_count(user_id, license, sort, safe_search)
    flickr.photos.search(:text => user_id, :license => license, :sort => sort, :safe_search => safe_search, :per_page => 60, :page => 1).count
  end

  def render_flickr_sidebar_widget(user_id, license, sort, safe_search, columns = 2)
    begin
      photo_count = [user_photo_count(user_id, license, sort, safe_search),500].min
      photos = user_photos(user_id, license, sort, safe_search, photo_count)
      render  :partial => '/flickr/sidebar_widget', 
              :locals => { :photos => photos }
    rescue => exception
      render :partial => '/flickr/unavailable'
    end
  end

  def render_popular
    begin
      license = "1,2,3,4,5,6,7,9,10"
      sort = "interestingness-desc"
      photos = flickr.photos.search(:license => license, :sort => sort).first(100)
      render  :partial => '/flickr/sidebar_widget', 
              :locals => { :photos => photos}
    rescue => exception
      render :partial => '/flickr/unavailable'
    end
  end
end

