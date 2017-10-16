module FlickrHelper
  def user_photos(user_id, license, sort, safety, photo_count)
    flickr.photos.search(:text => user_id, :license => license, :sort => sort, :safe_search => safety).first(photo_count)
  end

  def user_photo_count(user_id, license, sort, safety)
    flickr.photos.search(:text => user_id, :license => license, :sort => sort, :safe_search => safety).count
  end

=begin
  *** VALID SAFE-SEARCH API CALL from web API ***
  method=flickr.photos.search
  &api_key=4129408b320ee232c70d66a0c89c08aa
  &safe_search=3
  &format=json
  &nojsoncallback=1
  &auth_token=72157687120645091-eb2e82ddad745771
  &api_sig=3edc9c86edb5dff1026d003f03886c75
=end

  def render_flickr_sidebar_widget(user_id, license, sort, safety, columns = 2)
    begin
      photo_count = [user_photo_count(user_id, license, sort, safety),100].min
      photos = user_photos(user_id, license, sort, safety, photo_count).in_groups_of(4)
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

