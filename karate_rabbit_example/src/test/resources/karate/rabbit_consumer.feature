Feature: Verify events via RabbitMQ

  #Define the Consumer Queue variables
  Background:
    * def QueueConsumer = Java.type('co.com.karate.Consumer')
    * def consumer = new QueueConsumer()
  #Consumer listens to a Queue
  #Once the message is consumed, we can add an assertion
  Scenario: Verify event

      #in real world, this can be a different microservice which generates an event
      # Consumer should get "triggered"/ react on an event
    * def event = consumer.listen()
    * def message = consumer.getList()
    * def person = message.map(x => karate.fromString(x))
    * print person
  #Asserting if the 1st persons name is Person1
    * match person[0].name == "Person1"
  #Asserting if the there is any name = Person10
    * match person[*].name contains 'Person10'
  #Asserting if the 8th persons age is 37
    * match person[8].age == 37
  #Asserting if the number of persons = 10
    * match person == '#[10]'