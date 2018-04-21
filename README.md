# API

This ruby on rails application is a gateway API that serves to filter incoming
reports and validate the incoming data before saving the raw data in a postgres
data lake.

# Setup
## 1. Make sure you have a ruby version manager (asdf or rbenv)
Run the commands below after the `$` sign, you need to get at least one of the outputs. If not, google `asdf version manager` and follow the instructions on their github of how to install the version manager and it's ruby plugin.
```bash
$ asdf --version
v0.4.3
$ $ rbenv --version
rbenv 1.1.0-2-g4f8925a
```
## 2. Install correct ruby version:
```bash
$ cd rails_api
$ cat .ruby-version
2.5.1
$ ruby -v
ruby 2.5.1p57 (2018-03-29 revision 63029) [x86_64-darwin17]
```
As seen in the output above, `2.5.1` is installed as specified by ruby-version. If this is not the case for you, run this:
```bash
$ asdf install ruby 2.5.1
# wait until completion
$ asdf local ruby 2.5.1
$ gem install bundler
```
## 3. Install postgresql
Make sure it's installed and running (google if you don't know how)
The application will expect a user with username `trevlig` and password `trevlig123` that is superuser existing.

## 4. Prep the application
```bash
$ bundle # short for bundle install, installs all dependencies
$ rails db:setup
```

## 5. Run the application
```bash
 $ rails s # short for rails server
```
