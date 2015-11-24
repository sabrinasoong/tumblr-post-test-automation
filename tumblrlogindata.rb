require 'YAML'
file = YAML.load_file("./login_data.yml")

file["login"].each do |login|
  driver.find_element(login["username"], 
    login["password"])
end