class StaticPagesController < ApplicationController
  def home
    return false unless logged_in?
    @micropost = current_user.microposts.build
    @feed_items = current_user.feed.paginate(per_page: Settings.per_page_size,
      page: params[:page])
  end

  def help; end

  def about; end

  def contact; end
end
