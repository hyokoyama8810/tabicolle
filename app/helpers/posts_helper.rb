# frozen_string_literal: true

module PostsHelper
  def gravatar_for(user)
    # [why]GravatarはユーザーのメールアドレスをMD5でハッシュ化したものをidとして､URLに組み込んでいるから
    gravatar_id = Digest::MD5.hexdigest(user.email.downcase)
    gravatar_url = "https://secure.gravatar.com/avatar/#{gravatar_id}"
    image_tag(gravatar_url, alt: user.name, class: 'gravatar')
  end

  # 渡されたユーザーがカレントユーザーであればtrueを返す
  def current_user?(user)
    user && user == current_user
  end
end
