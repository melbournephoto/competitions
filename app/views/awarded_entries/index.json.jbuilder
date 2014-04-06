json.entries @entries do |entry|
  json.title entry.title
  json.photographer entry.user.name
  json.competition entry.competition.title
  json.section entry.section.title
  json.rating entry.rating.title
  json.thumb 'http://' + ENV['WEB_HOSTNAME'] + entry.photo.thumb.url
  json.carousel 'http://' + ENV['WEB_HOSTNAME'] + entry.photo.carousel.url
  json.url entry_url(entry)
end
