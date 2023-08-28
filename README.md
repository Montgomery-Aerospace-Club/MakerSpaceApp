# monty_makerspace

A flutter thingy by Eddie Tang 2025

## resources

https://stackoverflow.com/questions/69316963/flutter-web-access-development-server-from-another-device


## Run server

`python -m http.server 6969 --bind  192.168.86.111`

use `netstat -tuln | grep 8080` on linux to check if processes are running

or just run `netstat` and wait for something to start with `192.` etc then use that ip address without the :8080 ending or smth

# personal log 

> 8/27/2023

Heres a small amount of bragging because I want to highlight the small details in this that I learned for just this app/implemented lol (you can ignore this i just want to write it down for myself):
- This search bar is object-ified, which means that I can easily create new search bar widgets 

A cool thing is that the search function can be replaced for a custom one (the one you see in the video is the default search function

- There is secure-storage caching support which means the display data feature (which is search bar + the view below) works offline
- There is something called a provider in the language I am using and I implemented that as well (in all my projects I've never used one because I didn't get the chance nor understanding to use one) 

what it does is that it improves performance by a lot and shortens the code usage and clean-ess massively. 

it is also used by a lot of big coding projects which is cool to know

- it was my first time using another code feature in this language and my implementation worked the first time as well B)