module FlickrHelper
  def user_photos(user_id, photo_count)
    flickr.photos.search(:tags => user_id, :license => 9).first(photo_count)
  end

  def user_photo_count(user_id)
    flickr.photos.search(:tags => user_id, :license => 9).count
  end

  def render_flickr_sidebar_widget(user_id, columns = 2)
    begin
      photo_count = [user_photo_count(user_id),12].min
      photos = user_photos(user_id, photo_count).in_groups_of(3)
      render  :partial => '/flickr/sidebar_widget', 
              :locals => { :photos => photos }
    rescue => exception
      render :partial => '/flickr/unavailable'
    end
  end
end

