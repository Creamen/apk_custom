#!/bin/sh
echo "<div style=\"font-family: monospace\">"
perl -- /run/httpd/sites/cgi/roffit -mandoc -T html -P -r -P -l | egrep -v '(<html>|<head>|<meta|<title>|</title>|</head>|<body>|</body>|</html>|<!DOCTYPE|"http://www.w3.org)'
echo "</div>"

