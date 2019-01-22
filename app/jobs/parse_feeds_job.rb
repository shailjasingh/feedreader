class ParseFeedsJob < ApplicationJob
	require 'open-uri'
  queue_as :default

  def perform(*args)
    Feed.all.each do |feed|
      data = Nokogiri::HTML(open(feed.url))
      title = data.at("title").try(:text)
      content = data.at("content").try(:text)
      author = data.at("author").try(:text)
      url = data.at("url").try(:text)
      published = data.at("published").try(:text)
      local_entry = feed.entries.where(title: title).first_or_initialize
      local_entry.update_attributes(content: content, author: author, url: url, published: published)
    end
  end
end
