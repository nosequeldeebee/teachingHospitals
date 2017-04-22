# teachingHospitals
displays US teaching hospitals through Go API and Elm page

[Try me!](trink.io:9090)

# API and Webserver Info

A JSON API endpoint of all US teaching hospitals is exposed through a Go webserver.
The front end is also served concurrently through another port.

# Front end

Written in Elm, the API data is displayed in a table. The user can dynamically search for hospital names and sort columns.

