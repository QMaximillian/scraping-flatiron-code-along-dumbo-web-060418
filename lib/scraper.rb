require 'nokogiri'
require 'open-uri'

require_relative './course.rb'

class Scraper
  
    def print_courses
    self.make_courses
    Course.all.each do |course|
      if course.title
        puts "Title: #{course.title}"
        puts "  Schedule: #{course.schedule}"
        puts "  Description: #{course.description}"
      end
    end
  end

  def get_page
    html = open('http://learn-co-curriculum.github.io/site-for-scraping/courses')
    doc = Nokogiri::HTML(html)
    doc
  end

  def get_courses
    get_page.css(".posts-holder")
  end
  
  def make_courses
    course = Course.new
    get_courses.map do |post|
      course.title = post.css('h2').text
      course.schedule = post.css('.date').text
      course.description = post.css('p').text
    end
  end
end



