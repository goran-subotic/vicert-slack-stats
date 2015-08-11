#Slack Statistics

The purpose of this application is to colect users and number of messages for each user from Slack. The data is displayed in application home page. 
Application is colecting the data througth scheduled tasks. There are two implementation of the jobs:
 - Sidekiq
 - Delayed Job


###System dependencies

* Ruby v2.1.5
* Rails v4.2.3
* Redis

In order to execute Sidekiq job, it is necesary to have Redis running on localhost:6379.

###Configuration

First, it is necessary to configure the Slack token by filling: 
```
config.x.slack_key
```
property for desired environment  ( development.rb, in production.rb or test.rb)


In order to set up which job to be executed (Sidekiq or DejayedJob) and time of execution it is necessary to update /config/initializers/task_scheduler.rb file:

Example where DelayedJob is active:

```ruby
#It will execute the task every 55 min
scheduler.every("55s") do
  Delayed::Job.enqueue SlackData::CollectSlackUsersJob.new("slack_users")
end

scheduler.every("50s") do
  Delayed::Job.enqueue SlackData::CollectSlackMessagesJob.new("slack_messages")
end
```

Example where Sidekiq is active:

```ruby
#It will execute task every 55 min
scheduler.every("55s") do
  SlackWorker.perform_async(:slack)
end
```






###Database creation
	
The application is using sqlite database.

Execute 

```
> rake db:migrate RAILS_ENV=<env>
```
to setup the database.
	

###Deployment instructions

To simply start the application, execute:

```
> rails s
```

For DelayedJob worker to start, execute: 

```
> rake jobs:work
```

For Sidekiq worker to start, execute: 

```
> bundle exec sidekiq
```

###Rspec tests

To execute tests, run:

```
bundle exec rspec
```

We have used FactoryGirl (with Faker) for mocking models. And to mock external API calls to Slack, we utilized WebMock gem.


### Application URLs

Following are important URLs:


 - localhost:3000 - Page with users and number of messages can be seen here
 - localhost:3000/sidekiq - Sidekiq queue status
 - localhost:3000/delayed_job/overview - DelayedJob status
 - localhost:3000/job_scores - DelayedJob jobs statistics are displayed on this page
