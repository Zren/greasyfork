# GreasyFork

## Install

### Linux

	sudo apt-get ruby libmysqlclient-dev libsqlite3-dev
	gem install bundler
	sudo gem install therubyracer
	sudo gem install libv8
	bundle install
	sudo gem install rack

* Rename `config/database.example.yml` to `config/database.yml` and edit the values there in.
* Run `rackup`, it should error with ``raise_no_secret_key': Devise.secret_key was not set. Please add the following to your Devise initializer`.
* Rename `config/initializers/devise.examples.rb` to `config/initializers/devise.rb` and add the `config.secret_key = ''` line from the previous step into it. Look for `# config.secret_key` for placement (it should be at the top).

	rackup

* GreasyFork should now be running on http://localhost:9292
