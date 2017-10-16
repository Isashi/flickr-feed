Start by adding secrets to project:

`bundle exec figaro`

Add to `application.yml` :

`FLICKR_API_KEY = <API Key, no quotation marks>` and 

`FLICKR_API_SECRET = <API Secret, no quotation marks` 

(both obtained from [Flickr API](https://www.flickr.com/services/apps))

Inside a terminal window:
```
token = flickr.get_request_token
auth_url = flickr.get_authorize_url(token['oauth_token'], :perms => 'delete')

puts "Open this url in your browser to complete the authentication process : #{auth_url}"
puts "Copy here the number given when you complete the process."
verify = gets.strip

flickr.get_access_token(token['oauth_token'], token['oauth_token_secret'], verify)
login = flickr.test.login
puts "You are now authenticated as #{login.username} with token #{flickr.access_token} and secret #{flickr.access_secret}"
```

```
# Example POST for safe_search=3

# https://api.flickr.com/services/rest/
#   &auth_token=72157686242865152-b7eede230e80b888
#   &api_key=aaee9cddc0e152ae0fc09f87763c999b
#   &format=json
#   &method=flickr.photos.search
#   &nojsoncallback=1
#   &safe_search=3
#   &api_sig=9a7701e82080df41e310d1589b736aca
```

Base URL is all above params (minus `api_sig`) in alphabetical order
then url_encoded. Create MD5 from base_url to use in API call

```
base_url = 'POSThttps://api.flickr.com/services/rest/&auth_token=72157686242865152-b7eede230e80b998&api_key=aaee9cddc0e152ae0fc09f87763c828a&format=json&method=flickr.photos.search&nojsoncallback=1&safe_search=3'
encoded_url = URI.encode_www_form_component(base_url)

args = {}
args[:auth_token] = token['oauth_token']
args[:api_key] = ENV['FLICKR_API_KEY']
args[:format] = 'json' 
args[:nojsoncallback] = 1 
args[:safe_search] = 3 
args[:api_sig] = Digest::MD5.hexdigest(encoded_url)
args[:method] = 'flickr.photos.search'
```
Finally, we make the API call

`photos = flickr.photos.search(args)`
