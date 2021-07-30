# frozen_string_literal: true

# ----------------- Topic: Cookies ---------------

# Example: cookies method
class CommentsController < ApplicationController
  def new
    @comment = Comment.new(author: cookies[:commenter_name])
  end

  def create
    @comment = Comment.new(comment_params)
    if @comment.save
      flash[:notice] = 'Thanks for your comment!'
      if params[:remember_name]
        cookies[:commenter_name] = @comment.author
      else
        cookies.delete(:commenter_name)
      end
      redirect_to @comment.article
    else
      render action: 'new'
    end
  end
end

# Example: Date and Time objects are serialized as strings
class CookiesController < ApplicationController
  def set_cookie
    cookies.encrypted[:expiration_date] = Date.tomorrow # => Thu, 20 Mar 2014
    redirect_to action: 'read_cookie'
  end

  def read_cookie
    cookies.encrypted[:expiration_date] # => "2014-03-20"
  end
end
