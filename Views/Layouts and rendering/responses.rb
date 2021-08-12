# frozen_string_literal: true

# -------------------- Creating Responses --------------------------

# There are three ways to create an HTTP response:

# 1. render
# 2. redirect_to
# 3. head

# Example: In the controller

def update
  @book = Book.find(params[:id])
  if @book.update(book_params)
    redirect_to(@book)
  else
    render 'edit'
  end
end

# ------------- Using render --------------

# ---- Using render with :inline

render inline: '<% products.each do |p| %><p><%= p.name %></p><% end %>'

# ---- Rendering Text

render plain: 'OK'

# ----- Rendering HTML

render html: helpers.tag.strong('Not found')

# ----- Rendering JSON

render json: @product

# ----- Rendering XML

render xml: @product

# ----- Rendering Vanilla JavaScript

render js: "alert('Hello Rails');"

#------ Rendering raw body

render body: 'raw'

# ----- Rendering raw file

render file: "#{Rails.root}/public/404.html", layout: false

# ----- Rendering objects

render MyRenderable.new

# ----- Rendering status

render status: 500
render status: :forbidden

# ------ render with varients

render variants: %i[mobile desktop]

# --------------- Using redirect_to -----------------

# Example:
redirect_to photos_url

# Example with status code
redirect_to photos_url, status: 301

# Example:
def index
  @books = Book.all
end

def show
  @book = Book.find_by(id: params[:id])
  redirect_to action: :index if @book.nil?
end

# --------------- Using head To Build Header-Only Responses -----------------

# Example:
head :bad_request

# Example: with other information
head :created, location: photo_path(@photo)


