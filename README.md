# monty_makerspace

A flutter thingy by Eddie Tang 2025

## resources

https://stackoverflow.com/questions/69316963/flutter-web-access-development-server-from-another-device


## Run server

`python -m http.server 6969 --bind  192.168.86.111`

use `netstat -tuln | grep 8080` on linux to check if processes are running

or just run `netstat` and wait for something to start with `192.` etc then use that ip address without the :8080 ending or smth


If you're having trouble connecting to the HTTP server you started using `python -m http.server` with the `--bind 0.0.0.0` option, there could be a few reasons for the issue. Here are some steps you can take to troubleshoot and resolve the problem:

1. **Check Firewall Settings**: Ensure that your computer's firewall settings are not blocking incoming connections to the specified port (8080 in this case). You might need to create an exception in your firewall settings to allow traffic on that port.

2. **Check Antivirus or Security Software**: If you have antivirus or security software installed, it might be blocking incoming connections. Temporarily disabling the software or adding an exception for the Python executable could help.

3. **Confirm Server is Running**: Double-check that the Python HTTP server is running and has bound to the correct IP and port. When you run the command `python -m http.server 8080 --bind 0.0.0.0`, it should display a message like `Serving HTTP on 0.0.0.0 port 8080 ...`.

4. **Check IP and Port**: Make sure you're trying to access the server from the correct IP address and port. If you're accessing the server from the same machine, you can use `http://localhost:8080` in your web browser. If you're trying to access it from another device on the same network, you'll need to use the IP address of the machine running the server, followed by `:8080`.

5. **Network Configuration**: Ensure that your network configuration allows communication between devices on the same network. Devices on the same subnet should be able to communicate with each other.

6. **Other Processes on Port 8080**: Check if there are any other processes or applications using port 8080. You can use the `netstat` command to see if there's any conflict. Run `netstat -ano | findstr :8080` to check if the port is already in use.

7. **Python Version**: Ensure that you're using a compatible version of Python. The `http.server` module is available in Python 3.x. If you have both Python 2 and Python 3 installed, make sure you're using the correct command.

8. **Try a Different Port**: If you're still having trouble, try using a different port (e.g., 8000) to see if the issue persists. Sometimes certain ports might be restricted or blocked by the system.

9. **Restart the Server**: If all else fails, try stopping the server and then starting it again. This can sometimes resolve any issues that might have arisen during the initial setup.

10. **Check Web Browser**: If you're using a web browser to access the server, make sure the browser is functioning properly. You could try a different browser or clearing cache and cookies.

If you've tried these steps and are still unable to connect to the server, there might be more complex networking issues at play, and it could be helpful to seek assistance from someone familiar with your network setup.

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

# What is this :skull:
https://data-flair.training/blogs/python-online-library-management-system/