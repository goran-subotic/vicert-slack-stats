#Slack Statistics

The purpose of this application is to colect users and number of messages for each user from Slack. The data is displayed on the application home page. 
Application is colecting the data through scheduled tasks. There are two implementation of the jobs:
 - Sidekiq
 - Delayed Job


###System dependencies

* Ruby v2.1.5
* Rails v4.2.3
* Redis

In order to execute Sidekiq job, it is necesary to have Redis running on localhost:6379.

###Configuration

First, it is necessary to configure the Slack token by setting the following property for desired environment within the appropriate config file ( development.rb, production.rb or test.rb): 
```
config.x.slack_key
```

In order to set up which job (Sidekiq or DejayedJob) should be executed and the time of its execution it is necessary to update the /config/initializers/task_scheduler.rb file:

An example where DelayedJob is active:

```ruby
#It will execute the task every 55 min
scheduler.every("55s") do
  Delayed::Job.enqueue SlackData::CollectSlackUsersJob.new("slack_users")
end

scheduler.every("50s") do
  Delayed::Job.enqueue SlackData::CollectSlackMessagesJob.new("slack_messages")
end
```

An example where Sidekiq is active:

```ruby
#It will execute task every 55 min
scheduler.every("55s") do
  SlackWorker.perform_async(:slack)
end
```






###Database creation
	
The application is using sqlite database.

Execute the following command to set up the database:

```
> rake db:migrate RAILS_ENV=<env>
```

###Deployment instructions

To start the application, execute the following command:

```
> rails s
```

For the DelayedJob worker to start, execute: 

```
> rake jobs:work
```

For the Sidekiq worker to start, execute: 

```
> bundle exec sidekiq
```

###Rspec tests

To execute tests, run:

```
bundle exec rspec
```

We have used FactoryGirl (with Faker) for mocking models. To mock external API calls to Slack, we utilized the WebMock gem.


### Application URLs

Following are important URLs:


 - localhost:3000 - Page with users and number of messages
 - localhost:3000/sidekiq - Sidekiq queue status
 - localhost:3000/delayed_job/overview - DelayedJob status
 - localhost:3000/job_scores - DelayedJob jobs statistics
