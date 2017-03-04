jordan = User.create(username: "jordan-storz")
zelda  = User.create(username: "zelda-princess")

library1 = Library.create(user: jordan)
library2 = Library.create(user: zelda)

book1 = Book.create(
  title: "Build a Blog with Ruby on Rails - part 1",
  content: "Ruby on Rails is an awesome framework for quickly and easily setting up a web application. In this tutorial I will show you how to build a blog platform using Ruby on Rails, we will make use of the gem ckeditor which is an integration gem for Ckeditor.",
  source_url: "https://scotch.io/tutorials/build-a-blog-with-ruby-on-rails-part-1",
  libraries: [library1, library2]
)

book2 = Book.create(
  title: "We finally did something about Android Performance",
  content: "Back in September, Codinghorror wrote a popular post on the state of android Javascript performance on Discourse’s Meta forum. It drew a lot of attention, and led to some fascinating discussions on our forum and behind the scenes with browser engineers.",
  source_url: "https://eviltrout.com/2016/02/25/fixing-android-performance.html",
  libraries: [library1]
)

tagNames = ["ruby", "rails", "ember", "android", "web"]

tagNames.each_with_index.map do |tagName, index|
  tag = Tag.create(name: tagName)
  index <= 1 ? book1.tags << tag : book2.tags << tag
end

zelda.followers << jordan
