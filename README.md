# Octo Events

Octo Events is an application that listens to Github Events via webhooks and exposes by an API for later use.

![alt text](imgs/octo_events.png)


## 1. How to run the project?

Follow the steps below to run the project:

1. Run the following commands:
```
  bundle install
  rails db:create
  rails db:migrate
```
2. Run rails server, and you'll see something like this:
```
  ---------------------NGROK-----------------------------
  STATUS: running
  PORT: 3000
  HTTP: http://yoururl.ngrok.io
  HTTPS: https://yoururl.ngrok.io
  ---------------------NGROK-----------------------------
```
3. Go to your repository/organization page in GitHub
4. In settings > WebHooks, create a new webhook
5. Insert the HTTP or HTTPS URL that rails server alerted you, plus '/events', for example: http://myurl.ngrok.io/events/
6. Define the Content-Type to application/json
5. Select the type of events you wanna receive, but since we are working only with issues, click on 'Let me select individual events' and finally 'Issues & Issue comments'.
6. Mark the active checkbox and add the WebHook

NGROK was used to run this application in the development environment, and it considers that your NGROK is run by typing 'ngrok'. If it doesn't run you need to open the rails main folder, go to config > puma.rb, and on the options variable on the end of the file, add the path to run your NGROK:
```
 options = {
      addr: ENV.fetch("PORT") { 3000 },
      config: '~/.ngrok' # The path goes here
    }
```

For more information, access the negrok-tunnel gem page on GitHub: https://github.com/bogdanovich/ngrok-tunnel

## 2. Executing tests

The RSpec gem was used to construct the tests. To run all of them, just run on the terminal:

> rspec

## 2. Routes

* GitHub will post the events on /events
* You can open an issue's events on the path /issues/#{issue_number}/events

OBSERVATION: The application was designed to create a new Issue in case it receives an Event of a nonexistent Issue.
