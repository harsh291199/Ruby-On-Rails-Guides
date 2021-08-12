# frozen_string_literal: true

# --------------- Structuring Layouts ----------------

# ------- Asset Tag Helpers -----------

# Example: auto_discovery_link_tag
# <%= auto_discovery_link_tag(:rss, {action: "feed"}, {title: "RSS Feed"}) %>

# Example: javascript_include_tag
# <%= javascript_include_tag "main" %>

# Example: stylesheet_link_tag
# <%= stylesheet_link_tag "main" %>

# Example: image_tag
# <%= image_tag "header.png" %>

# Example: video_tag
# <%= video_tag "movie.ogg" %>

# Example: audio_tag
# <%= audio_tag "music.mp3" %>

# -------  Understanding yield -----------

# Example:

# <html>
#   <head>
#   </head>
#   <body>
#   <%= yield %>
#   </body>
# </html>

# Example: Multiple yields

# <html>
#   <head>
#   <%= yield :head %>
#   </head>
#   <body>
#   <%= yield %>
#   </body>
# </html>

# ------- Using the content_for Method -----------

# Example:

# <% content_for :head do %>
#   <title>A simple page</title>
# <% end %>
#
# <p>Hello, Rails!</p>

# ------------- Using Partials -------------------

# Example:
# <%= render "menu" %>
# This will render a file named _menu.html.erb

# Example:
# <%= render "shared/ad_banner" %>
#
# <h1>Products</h1>
#
# <p>Here are a few of our fine products:</p>
# ...
#
# <%= render "shared/footer" %>

# ------------ Example: Passing Local Variables

# new.html.erb
# <h1>New zone</h1>
# <%= render partial: "form", locals: {zone: @zone} %>

# edit.html.erb
# <h1>Editing zone</h1>
# <%= render partial: "form", locals: {zone: @zone} %>

# _form.html.erb
# <%= form_with model: zone do |form| %>
#   <p>
#     <b>Zone name</b><br>
#     <%= form.text_field :name %>
#   </p>
#   <p>
#     <%= form.submit %>
#   </p>
# <% end %>

# ----------- Example: Rendering Collections

# index.html.erb
# <h1>Products</h1>
# <%= render partial: "product", collection: @products %>

# _product.html.erb
# <p>Product Name: <%= product.name %></p>

# ------------- Using Nested Layouts -------------------

# Example: application.html.erb

# <html>
# <head>
#   <title><%= @page_title or "Page Title" %></title>
#   <%= stylesheet_link_tag "layout" %>
#   <style><%= yield :stylesheets %></style>
# </head>
# <body>
#   <div id="top_menu">Top menu items here</div>
#   <div id="menu">Menu items here</div>
#   <div id="content"><%= content_for?(:content) ? yield(:content) : yield %></div>
# </body>
# </html>
