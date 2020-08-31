module ApplicationHelper
  # ページタイトルを与えたページにのみページタイトル付加した形で返す
  def full_title(page_title = "")
    base_title = "Tabicolle"
    if page_title.empty?
      base_title
    else
      page_title + " | " + base_title
    end
  end
end
