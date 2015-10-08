import Swell

Swell.createServer { (request, response) in
    response.addHeader("X-Powered-By", "Swell")
    response.end("Hey what's up brian!\n")
}.listen(8000)
