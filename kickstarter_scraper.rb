# require libraries/modules here
require 'nokogiri'
require 'pry'

def create_project_hash
  # write your code here
  html = File.read('fixtures/Kickstarter.html')
  kickstarter = Nokogiri::HTML(html)
  kickstarter_projects = kickstarter.css("li.project.grid_4")

  projects = {}
  kickstarter_projects.each do |project|
    title = project.css("h2.bbcard_name strong a").text
    projects[title.to_sym] = {
      image_link: project.css(".projectphoto-little").attribute("src").value,
      description: project.css("p.bbcard_blurb").text,
      location: project.css(".location-name").text,
      percent_funded: project.css("li.first.funded strong").text.gsub("%", "").to_i
    }
  end
  projects
end
