# ReadMe 

Make sure you read **all** of this document carefully, and follow the guidelines in it.

## Requirements

There is only one test here currently, please review and get back to us.

## What We Care About

Use any libraries that you would normally use if this were a real production App. Please note: we're interested in your code & the way you solve the problem, not how well you can use a particular library or feature.

*We're interested in your method and how you approach the problem just as much as we're interested in the end result.*

Here's what you should strive for:

- Good use of structure, security, and performance best practices.
- Solid testing approach.
- Extensible code.


## Q&A
> Where should I send back the result when I'm done?

Fork this repo and send us a pull request when you think you are done. There is no deadline for this task unless otherwise noted to you directly.

> What if I have a question?

Just create a new issue in this repo and we will respond and get back to you quickly.

***

# QR-generator

Make sure you have read the ReadMe first.

Be sure to read **all** of this document carefully, and follow the guidelines within.

## Context

- A client needs to display a QR code in their App.
- The QR code can be used to identify one's profile or a certain feature.


## Requirements

### Tasks
1. Build a simple API server that provides an endpoint which generates a random seed used to create QR code. (if you cannot build an API server, we can supply a lambda to do this for you)
2. Build a simple App that can call the seed endpoint and generate a QR code based on the seed.
3. Build a "Scan" feature that can demonstrate how it works (see the mock) and how it could be validated with another endpoint.
4. Be sure the app will use the below UI and will have a navigation pattern present.
5. Write clear **documentation** on how it's designed and how to execute the code.
6. Provide proper unit tests.
7. Write concise and clear commit messages.

### UI

Here's a quick mock-up of how it could look like (simple like Material Design!):

### API

(in Open API 3.0 format)

    paths:
      /seed:
        get:
          description: Get a seed that can be used to generate a QR code
          responses:
            '200':
              description: seed generated
              content:
                application/json:
                  schema:
                    $ref: '#/components/schemas/Seed'
    components:
      schemas:
        Seed:
          type: object
          properties:
            seed:
              type: string
              example: d43397d129c3de9e4b6c3974c1c16d1f
            expires_at:
              type: dateTime
              description: ISO date-time
              example: '1979-11-12T13:10:42.24Z'


### Tech stack

- API
    - Use anything for the backend. We generally use Node.js, so this is prefered but not required.
- Cross platform
    - Use Flutter
- Android
    - Use Kotlin
- iOS
    - Use Swift


### Advanced requirements
These may be used for additional challenges. You can freely skip these if you are not asked to do them; feel free to try them out if you're up for it.

- Provide an auto-refresh strategy, for example with the expires_at value.
- (Android) Use DI with Dagger2
- Provide an offline QR code access strategy, for example with a cache.
