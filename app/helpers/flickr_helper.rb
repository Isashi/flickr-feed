module FlickrHelper
  def user_photos(user_id, license, sort, safe_search, photo_count)
    flickr.photos.search(:text => user_id, :license => license, :sort => sort, :safe_search => safe_search).first(photo_count)
  end

  def user_photo_count(user_id, license, sort, safe_search)
    flickr.photos.search(:text => user_id, :license => license, :sort => sort, :safe_search => safe_search).count
  end

  def render_flickr_sidebar_widget(user_id, license, sort, safe_search, columns = 2)
    begin
      photo_count = [user_photo_count(user_id, license, sort, safe_search),100].min
      photos = user_photos(user_id, license, sort, safe_search, photo_count).in_groups_of(4)
      render  :partial => '/flickr/sidebar_widget', 
              :locals => { :photos => photos }
    rescue => exception
      render :partial => '/flickr/unavailable'
    end
  end

  def render_recent
    begin
      license = "7,9,10"
      photos = flickr.photos.search(:license => license).first(100).in_groups_of(4)
      render  :partial => '/flickr/sidebar_widget', 
              :locals => { :photos => photos}
    rescue => exception
      render :partial => '/flickr/unavailable'
    end
  end
end

