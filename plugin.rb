# frozen_string_literal: true

# name: discourse-chinese-onebox
# about: Add support for Chinese video sites embeds in Discourse
# version: 1.0.2
# authors: TreeNewBee
# url: https://github.com/TheTNB/discourse-chinese-onebox
# required_version: 2.7.0

require "onebox"

class Onebox::Engine::BilibiliOnebox
  include Onebox::Engine

  matches_regexp(/^https?:\/\/(?:www\.)?bilibili\.com\/video\/([A-Za-z0-9]+)\/?$/)
  always_https

  def video_id
    return unless uri&.path

    if (match = uri.path.match(/\/video\/av(\d+)(\.html)?.*/))
      "aid=#{match[1]}"
    elsif (match = uri.path.match(/\/video\/BV([A-Za-z0-9]+)(\.html)?.*/))
      "bvid=#{match[1]}"
    end
  end

  def to_html
    <<-HTML
      <iframe
        src='https://player.bilibili.com/player.html?#{video_id}&p=1'
        frameborder="0"
        framespacing="0"
        width='100%'
        height='420'
        allowfullscreen>
      </iframe>
    HTML
  end

  def placeholder_html
    to_html
  end
end

class Onebox::Engine::YoukuOnebox
  include Onebox::Engine

  matches_regexp(/^https?:\/\/v\.youku\.com\/v_show\/id_([A-Za-z0-9=]+)\.html/)
  always_https

  def video_id
    return unless uri&.path

    match = uri.path.match(/\/v_show\/id_([A-Za-z0-9=]+)\.html/)
    match[1] if match
  end

  def to_html
    <<-HTML
      <iframe
        src='https://player.youku.com/embed/#{video_id}'
        frameborder="0"
        framespacing="0"
        width='100%'
        height='420'
        allowfullscreen>
      </iframe>
    HTML
  end

  def placeholder_html
    to_html
  end
end

class Onebox::Engine::TencentVideoOnebox
  include Onebox::Engine

  matches_regexp(/^https?:\/\/v\.qq\.com\/x\/page\/([A-Za-z0-9]+)\.html/)
  always_https

  def video_id
    return unless uri&.path

    match = uri.path.match(/\/x\/page\/([A-Za-z0-9]+)\.html/)
    match[1] if match
  end

  def to_html
    <<-HTML
      <iframe
        src='https://v.qq.com/txp/iframe/player.html?vid=#{video_id}'
        frameborder="0"
        framespacing="0"
        width='100%'
        height='420'
        allowfullscreen>
      </iframe>
    HTML
  end

  def placeholder_html
    to_html
  end
end
