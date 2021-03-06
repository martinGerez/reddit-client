# README

## General quotations
I use `6.0.3.2` RoR Version. And I use `webpacker` as the main asset bundler.
Also I decided to use Server Side rendering and use `Slim` as a templating engine. This is because I am much familiar and confident

## Overmind
You must have `Overmind` installed in local machine to use Procfile declared in `development` mode.
This handles Rails Server and Webpacker Server processes.

## Database config
This sample project uses Postgresql as a database.
Credentials for login into DB are set up in `credentials.yml`. Prior to start, you need to have created a user in PG with permissions to log in and Create DB.


# Explanation
This Reddit client has a fetcher to `/top.json` public endpoint.
I use HTTParty gem to make requests.
After retrieving posts from Reddit, I store it in a database, cleaning firs other legacy posts, to avoid have more than 50 every time.
As the user can dismiss one or all posts, if Reddit has no changes in top posts, if the user dismissed all posts and retry fetch, the status does not change.

The time consumption at the start of the project was a lot because I tried to start with data, retrieving and filtering posts.
After that, I started to work in frontend using Blueprint CSS as a grid layout and StimulusJS to add some behavior.

## UI
I decided to use `Blueprint CSS` for grid system, and `Metro UI` to use some fancy components like Cards among others. Only in this way and not in order to duplicate libraries

## Main Difficulties
Reddit has not good documentation. It was hard at the start because makes some confusion. My bad on spending a lot of time on it.
Blueprint was a new technology, and I consciously decided to work with it to know it and make this exercise more challenging.

## Devops
This project will be deployed to a VPS using UBUNTU.
Nginx + Passenger as web server.
Capistrano gems to automate deployment tasks.

## Testing
Te used testing suite is `Rspec`, which is one of the most popular testing frameworks in the Ruby ecosystem.
In controller/requests testing, it would be a good decision to use libraries like `VCR` and `Webmock`, to avoid making several requests to external systems.
Also, I consider it useful to improve coverage use SimpleCov to know the percentage of test coverage.
Libraries like `FactoryBot`, `DatabaseCleaner`, `ShouldaMatchers` are not critical, but are very useful to reduce time consumption in testing and make tests more cleaner (ShouldaMatchers in a special way).
