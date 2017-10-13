module FlickrHelper
  def user_photos(user_id, license, sort, photo_count)
    flickr.photos.search(:tags => user_id, :license => license, :sort => sort).first(photo_count)
  end

  def user_photo_count(user_id, license, sort)
    flickr.photos.search(:tags => user_id, :license => license, :sort => sort).count
  end

  def render_flickr_sidebar_widget(user_id, license, sort, columns = 2)
    begin
      photo_count = [user_photo_count(user_id, license, sort),100].min
      photos = user_photos(user_id, license, sort, photo_count).in_groups_of(4)
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

