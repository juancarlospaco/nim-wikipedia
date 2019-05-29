import asyncdispatch, httpclient, strutils, json

const
  wikipediaUrl* = "https://wikipedia.org/w/api.php?format=json&formatversion=2"  ## Wikipedia API URL.
  mediaWikiUrl* = "https://mediawiki.org/w/api.php?format=json&formatversion=2" ## MediaWiki API URL.
  wikipediaUrlTest* = "https://test.wikipedia.org/w/api.php?format=json&formatversion=2" ## Test Wikipedia API URL (Fake).
  wikiMediaCommonsUrl* = "https://commons.wikimedia.org/w/api.php?format=json&formatversion=2" ## WikiMedia Commons API URL.


type
  WikipediaBase*[HttpType] = object ## Base object.
    timeout*: byte  ## Timeout Seconds for API Calls, byte type, 0~255.
    proxy*: Proxy  ## Network IPv4 / IPv6 Proxy support, Proxy type.
  Wikipedia* = WikipediaBase[HttpClient]           ##  Sync Wikipedia API Client.
  AsyncWikipedia* = WikipediaBase[AsyncHttpClient] ## Async Wikipedia API Client.

template clientify(this: Wikipedia | AsyncWikipedia): untyped =
  ## Build & inject basic HTTP Client with Proxy and Timeout.
  var client {.inject.} =
    when this is AsyncWikipedia: newAsyncHttpClient(
      proxy = when declared(this.proxy): this.proxy else: nil, userAgent="")
    else: newHttpClient(
      timeout = when declared(this.timeout): this.timeout.int * 1_000 else: -1,
      proxy = when declared(this.proxy): this.proxy else: nil, userAgent="")
  client.headers = newHttpHeaders({"dnt": "1", "accept":
    "application/json", "content-type": "application/json"})

proc foo*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
  ##
  clientify(this)
  discard
