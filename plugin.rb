# frozen_string_literal: true

# name: discourse-onebox-bilibili
# about: Add support for Bilibili video embeds in Discourse
# version: 1.0.0
# authors: TreeNewBee
# url: https://github.com/TheTNB/discourse-onebox-bilibili
# required_version: 2.7.0

require "onebox"

class Onebox::Engine::BilibiliOnebox
  include Onebox::Engine

  matches_regexp(/^https?:\/\/(?:www\.)?bilibili\.com\/video\/([a-zA-Z0-9]+)\/?$/)
  always_https

  def video_id
    match = uri.path.match(/\/video\/av(\d+)(\.html)?.*/)
    return "aid=#{match[1]}" if match && match[1]
    match = uri.path.match(/\/video\/BV([a-zA-Z0-9]+)(\.html)?.*/)
    return "bvid=#{match[1]}" if match && match[1]
  end

  def to_html
    <<-HTML
      <iframe
        src='https://player.bilibili.com/player.html?#{video_id}&p=1'
        frameborder="0"
        framespacing="0"
        width='100%'
        style='aspect-ratio: 16/9;margin:auto;'
        allowfullscreen>
      </iframe>
    HTML
  end

  def placeholder_html
    to_html
  end
end
