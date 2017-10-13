module FlickrHelper
  def user_photos(user_id, photo_count)
    flickr.photos.search(:tags => user_id, :license => 9).first(photo_count)
  end

  def user_photo_count(user_id)
    flickr.photos.search(:tags => user_id, :license => 9).count
  end

  def render_flickr_sidebar_widget(user_id, columns = 2)
    begin
      photo_count = [user_photo_count(user_id),100].min
      photos = user_photos(user_id, photo_count).in_groups_of(4)
      render  :partial => '/flickr/sidebar_widget', 
              :locals => { :photos => photos }
    rescue => exception
      render :partial => '/flickr/unavailable'
    end
  end

  def render_recent
    begin
      photos = flickr.photos.search(:license => "7,9,10").first(100).in_groups_of(4)
      render  :partial => '/flickr/sidebar_widget', 
              :locals => { :photos => photos }
    rescue => exception
      render :partial => '/flickr/unavailable'
    end
  end
end

