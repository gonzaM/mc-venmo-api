json.feed @feed_items do |feed_item|
  json.id           feed_item.id
  json.title        feed_item.feed_title
  json.description  feed_item.description
  json.created_at   feed_item.created_at
end
