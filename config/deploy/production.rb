role :app, %w{eebulle@146.185.163.64:77}
role :web, %w{eebulle@146.185.163.64:77}
role :db,  %w{eebulle@146.185.163.64:77}

# Define server(s)
server '146.185.163.64:77', user: 'eebulle', roles: %w{web app db}, primary: true

# SSH Options
# See the example commented out section in the file
# for more options.
set :ssh_options, {
    forward_agent: true,
    user: 'eebulle',
    port: 77
}