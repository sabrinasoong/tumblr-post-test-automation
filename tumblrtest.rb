require 'selenium-webdriver'
require 'YAML'
file = YAML::load_file("./login_data.yml")

driver = Selenium::WebDriver.for :firefox

driver.get "http://tumblr.com/login"
wait = Selenium::WebDriver::Wait.new(timeout: 30)

w1 = wait.until do
  waiting = driver.find_element id: "logo"
  waiting.send_keys :escape
end

w2 = wait.until do
  file["login"].each do |login|
    email = driver.find_element(name:"user[email]") 
    email.send_keys login["username"]
    password = driver.find_element(name: "user[password]")
    password.send_keys login["password"]
    password.submit
  end
  
end

w3 = wait.until do
  waiting2 = driver.find_element class: "post_avatar_link"
  waiting2.send_keys :escape
end

w4 = wait.until do
  driver.find_element(id: "Compose-button").click
  driver.find_element(class: "post-type-icon").click
  post_title = driver.find_element(class: "editor-plaintext")
  post_title.send_keys "This is a test post!\t Automatic test post!"
  driver.find_element(class: "create_post_button").click
  result = driver.find_elements(class: "post_body")
  result.each do |o| 
    if o.text == " Automatic test post!"
      puts "Test post is printed!"
    else
      puts "This isn't my post!"
    end
  end

end

