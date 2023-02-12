## Requirements

* Ruby version manager (f.e. https://github.com/rbenv/rbenv)

* Ruby version 3.1+

* SQLite3 DB

## Installation

* Update Ruby gem manager
  - Run in terminal: `gem update --system`

* Update gems
  - Run in terminal: `gem update`

* Clone the current repository, checkout the `feature/pizza_order_list` branch and then run in terminal inside its folder `bundle`

* Database initialization
  - Run in terminal: `bundle exec rake db:create`
  - Run in terminal: `bundle exec rake db:migrate`
  - Run in terminal: `bundle exec rake db:seed`
  - Now you have successfully populated your local development environment with test data

## Usage

* Application start
  - Run in terminal: `bundle exec rails server`
  - Now the application is ready to respond to the incoming requests on http://localhost:3000/

* Application usage
  - as this project offers a simple frontend, you are welcome to use any browser to open the mentioned address

  - List all available open pizza orders
  - `http://localhost:3000/index`

  - Clicking on `Complete` button will mark an order as complete and remove it from the screen

* Decisions made during the implementation
  - add validations to make the names unique, as well as prohibit entering incorrect numeric values
  - split all the resources and the relations between them into separate models with additional join tables to represent the connections between them
  - make sure, that we preload as much data from the DB, as possible by a single query to accelerate the process of further calculation of the total price per order, as well as querying the corresponding relations for display

