# Nationbuilder Webhooks Sample App

Currently the app accepts a post payload to the url https://murmuring-tundra-2773.herokuapp.com/webhooks, this payload is only generated by my nation **organizerkevincoleman** when someone is contacted. When the payload is sent, the app parses the payload and then logs a private note on the profile of the person who was contacted.

### Next steps
-Experiment with devise and see if I could create a process for others to create webhooks for their own nation if they have an API key