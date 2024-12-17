# Short-url
Url Shortener implementation based off of https://codingchallenges.fyi/challenges/challenge-url-shortener/, written in vlang

## Installation
1. Download the v language
2. Clone the repository and cd into it
3. Run ```v run .```

## Usage
There are just 3 endpoints
1. GET ```/new/:url```

Where "url" is the url you want to shorten, it will return the url for redirecting

2. GET ```/:short```

"short" is the shortened url that you received from ```/new/:url```, it will redirect you to the site you made earlier

3. DELETE `/:short`

This will remove the endpoint that was created
