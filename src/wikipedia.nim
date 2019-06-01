import asyncdispatch, httpclient, strutils, json
from xmlparser import parseXml
from xmltree import XmlNode


const
  o = "?format=json&formatversion=2&servedby=true&curtimestamp=true&responselanginfo=true&errorformat=plaintext&action="
  wikipediaUrl* = "https://wikipedia.org/w/api.php" & o ## Wikipedia API URL.
  mediaWikiUrl* = "https://mediawiki.org/w/api.php" & o ## MediaWiki API URL.
  wikipediaUrlTest* = "https://test.wikipedia.org/w/api.php" & o ## Test Wikipedia API URL (Fake).
  wikiMediaCommonsUrl* = "https://commons.wikimedia.org/w/api.php" & o ## WikiMedia Commons API URL.


type
  WikipediaBase*[HttpType] = object ## Base object.
    timeout*: byte ## Timeout Seconds for API Calls, byte type, 0~255.
    proxy*: Proxy             ## Network IPv4 / IPv6 Proxy support, Proxy type.
    token*: string            ## Auth Token
  Wikipedia* = WikipediaBase[HttpClient] ##  Sync Wikipedia API Client.
  AsyncWikipedia* = WikipediaBase[AsyncHttpClient] ## Async Wikipedia API Client.


template clientify(this: Wikipedia | AsyncWikipedia): untyped =
  ## Build & inject basic HTTP Client with Proxy and Timeout.
  var client {.inject.} =
    when this is AsyncWikipedia: newAsyncHttpClient(
      proxy = when declared(this.proxy): this.proxy else: nil, userAgent = "")
    else: newHttpClient(
      timeout = when declared(this.timeout): this.timeout.int *
          1_000 else: -1,
      proxy = when declared(this.proxy): this.proxy else: nil, userAgent = "")
  client.headers = newHttpHeaders({"dnt": "1", "accept":
    "application/json", "content-type": "application/json"})


proc login(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
  ## Check to see if an AbuseFilter matches a set of variables, an edit, or a logged AbuseFilter event.
  clientify(this)
  const o = "query&meta=tokens&type=createaccount|csrf|deleteglobalaccount|login|patrol|rollback|setglobalaccountstatus|userrights|watch"
  result = parseJson(await client.getContent(wikipediaUrlTest & o))


# proc abuseFilterCheckMatch*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Check to see if an AbuseFilter matches a set of variables, an edit, or a logged AbuseFilter event.
#   clientify(this)


# proc abuseFilterCheckSyntax*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Check syntax of an AbuseFilter filter.
#   clientify(this)


# proc abuseFilterEvalExpression*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Evaluates an AbuseFilter expression.
#   clientify(this)


# proc abuseFilterUnblockAutopromote*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Unblocks a user from receiving autopromotions due to an abusefilter consequence.
#   clientify(this)


# proc antispoof*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Check a username against AntiSpoof's normalisation checks.
#   clientify(this)


# proc blockUser*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Block a user.
#   clientify(this)


# proc bounceHandler*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Receive a bounce email and process it to handle the failing recipient.
#   clientify(this)


# proc categoryTree*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Internal module for the CategoryTree extension.
#   clientify(this)


# proc centralAuthToken*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Fetch a centralauthtoken for making an authenticated request to an attached wiki.
#   clientify(this)


# proc centralNoticeCdnCacheUpdateBanner*(
#     this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Request the purge of banner content stored in the CDN (front-end) cache for anonymous users, for the requested banner and language
#   clientify(this)


# proc centralNoticeChoiceData*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Get data needed to choose a banner for a given project and language
#   clientify(this)


# proc centralNoticeQueryCampaign*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Get all configuration settings for a campaign.
#   clientify(this)


# proc changeAuthenticationData*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Change authentication data for the current user.
#   clientify(this)


# proc checkToken*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Check the validity of a token from action=query&meta=tokens.
#   clientify(this)


# proc cirrusConfigDump*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Dump of CirrusSearch configuration.
#   clientify(this)


# proc cirrusMappingDump*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Dump of CirrusSearch mapping for this wiki.
#   clientify(this)


# proc cirrusProfilesDump*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Dump of CirrusSearch profiles for this wiki.
#   clientify(this)


# proc cirrusSettingsDump*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Dump of CirrusSearch settings for this wiki.
#   clientify(this)

# proc clearHasmsg*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Clears the hasmsg flag for the current user.
#   clientify(this)


# proc compare*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Get the difference between two pages.
#   clientify(this)

# proc createAccount*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Create a new user account.
#   clientify(this)

# proc cspReport*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Used by browsers to report violations of the Content Security Policy. This module should never be used, except when used automatically by a CSP compliant web browser.
#   clientify(this)

# proc cxConfiguration*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Fetch the Content Translation configuration json for the given language pair.
#   clientify(this)


# proc cxDelete*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Delete a draft translation created using the Content Translation extension.
#   clientify(this)


# proc cxPublish*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Save a page created using the Content Translation extension.
#   clientify(this)


# proc cxSave*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## This module allows to save draft translations by section to save bandwidth and to collect parallel corpora.
#   clientify(this)


# proc cxSuggestionList*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Manage the suggestion lists. Add suggestions to lists and remove them.
#   clientify(this)


# proc cxToken*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Get JWT tokens to authenticate with cxserver.
#   clientify(this)


# proc delete*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Delete a page.
#   clientify(this)


# proc deleteGlobalAccount*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Delete a global user.
#   clientify(this)


# proc echoMarkRead*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Mark notifications as read for the current user.
#   clientify(this)


# proc echoMarkSeen*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Mark notifications as seen for the current user.
#   clientify(this)


# proc edit*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Create and edit pages.
#   clientify(this)

# proc editMassMessageList*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Edit a mass message delivery list.
#   clientify(this)

# proc emailUser*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Email a user.
#   clientify(this)


# proc expandTemplates*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Expands all templates within wikitext.
#   clientify(this)

# proc fancyCaptchaReload*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Get a new FancyCaptcha.
#   clientify(this)

# proc featuredFeed*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Returns a featured content feed.
#   clientify(this)


# proc feedContributions*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Returns a user contributions feed.
#   clientify(this)

# proc feedRecentChanges*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Returns a recent changes feed.
#   clientify(this)

# proc feedWatchlist*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Returns a watchlist feed.
#   clientify(this)


# proc fileRevert*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Revert a file to an old version.
#   clientify(this)

# proc flagConfig*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Get basic information about review flag configuration for this site.
#   clientify(this)

# proc globalBlock*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Globally block or unblock a user.
#   clientify(this)


# proc globalPreferenceOverrides*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Change local overrides for global preferences for the current user.
#   clientify(this)

# proc globalPreferences*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Change global preferences of the current user.
#   clientify(this)

# proc globalUserRights*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Add/remove a user to/from global groups.
#   clientify(this)


# proc graph*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Access graph tag functionality.
#   clientify(this)


proc help*(this: Wikipedia | AsyncWikipedia, modules: string): Future[
    JsonNode] {.multisync.} =
  ## Display help for the specified modules.
  assert modules.split"|".len < 50, "Maximum number of modules is 50"
  clientify(this)
  const o = "help&submodules=true&wrap=true&toc=true&modules="
  result = parseJson(await client.getContent(wikipediaUrlTest & o & modules))


# proc imageRotate*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## This module has been disabled.
#   clientify(this)


# proc importFile*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Import a page from another wiki, or from an XML file.
#   clientify(this)

proc jsonConfig*(this: Wikipedia | AsyncWikipedia, namespace: int,
    command: string): Future[JsonNode] {.
  multisync.} =
  ## Allows direct access to JsonConfig subsystem.
  assert command in ["status", "reset", "reload"],
    "command must be one of status, reset, reload"
  clientify(this)
  result = parseJson(await client.getContent(
      wikipediaUrlTest & "jsonconfig&namespace=" & $namespace & "&command=" &
      command))


# proc jsonData*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Retrieve localized JSON data.
#   clientify(this)


# proc languageSearch*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Search for language names in any script.
#   clientify(this)

# proc linkAccount*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Link an account from a third-party provider to the current user.
#   clientify(this)

# proc login*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Log in and get authentication cookies.
#   clientify(this)


# proc logout*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Log out and clear session data.
#   clientify(this)

# proc manageTags*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Perform management tasks relating to change tags.
#   clientify(this)

# proc massMessage*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Send a message to a list of pages.
#   clientify(this)


# proc mergeHistory*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Merge page histories.
#   clientify(this)

# proc mobileView*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Returns data needed for mobile views.
#   clientify(this)

# proc move*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Move a page.
#   clientify(this)


# proc oathValidate*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Validate a two-factor authentication (OATH) token.
#   clientify(this)

# proc openSearch*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Search the wiki using the OpenSearch protocol.
#   clientify(this)

# proc options*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Change preferences of the current user.
#   clientify(this)


# proc pageTriageAction*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Mark an article as reviewed or unreviewed.
#   clientify(this)

# proc pageTriageList*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Get a list of page IDs for building a PageTriage queue.
#   clientify(this)

# proc pageTriageStats*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Get the stats for page triage.
#   clientify(this)


# proc pageTriageTagCopyVio*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Tag a revision as a likely copyright violation.
#   clientify(this)


# proc pageTriageTagging*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Add tags to an article.
#   clientify(this)


proc paramInfo*(this: Wikipedia | AsyncWikipedia, modules: string): Future[
    JsonNode] {.multisync.} =
  ## Obtain information about API modules.
  assert modules.split"|".len < 50, "Maximum number of modules is 50"
  clientify(this)
  const o = "paraminfo&helpformat=raw&modules="
  result = parseJson(await client.getContent(wikipediaUrlTest & o & modules))


# proc parse*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Parses content and returns parser output.
#   clientify(this)


# proc parsoidBatch*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Batch API for Parsoid
#   clientify(this)


# proc patrol*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Patrol a page or revision.
#   clientify(this)


# proc protect*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Change the protection level of a page.
#   clientify(this)


# proc purge*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Purge the cache for the given titles.
#   clientify(this)


# proc query*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Fetch data from and about MediaWiki.
#   clientify(this)


# proc readingLists*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Reading list write operations.
#   clientify(this)


# proc recordLint*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Record a lint error in the database
#   clientify(this)


# proc removeAuthenticationData*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Remove authentication data for the current user.
#   clientify(this)


# proc resetPassword*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Send a password reset email to a user.
#   clientify(this)


# proc review*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Review a revision by approving or de-approving it.
#   clientify(this)


# proc reviewActivity*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Advertise or de-advertise yourself as reviewing an unreviewed page or unreviewed changes.
#   clientify(this)


# proc revisionDelete*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Delete and undelete revisions.
#   clientify(this)


# proc rollback*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Undo the last edit to the page.
#   clientify(this)


proc rsd*(this: Wikipedia | AsyncWikipedia): Future[XmlNode] {.multisync.} =
  ## Export an RSD (Really Simple Discovery) schema.
  clientify(this)
  result = parseXml(await client.getContent(wikipediaUrlTest & "rsd"))


proc sanitizeMapdata*(this: Wikipedia | AsyncWikipedia,
    text: JsonNode): Future[JsonNode] {.
  multisync.} =
  ## Performs data validation for Kartographer extension
  clientify(this)
  result = parseJson(await client.postContent(
      wikipediaUrlTest & "sanitize-mapdata&text=" & $text))


# proc scribuntoConsole*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Internal module for servicing XHR requests from the Scribunto console.
#   clientify(this)


# proc setGlobalAccountStatus*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Set a global user's status.
#   clientify(this)


# proc setNotificationTimestamp*(this: Wikipedia | AsyncWikipedia): Future[
#     JsonNode] {.multisync.} =
#   ## Update the notification timestamp for watched pages.
#   clientify(this)


# proc setPageLanguage*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Change the language of a page.
#   clientify(this)


proc shortenUrl*(this: Wikipedia | AsyncWikipedia, url: string): Future[
    JsonNode] {.
  multisync.} =
  ## Shorten a long URL into a shorter one. Some servers may have this disabled.
  assert url.len > 4 and url.normalize.startsWith("http"),
    "URL must be valid HTTP URL"
  clientify(this)
  result = parseJson(await client.postContent(
      wikipediaUrlTest & "shortenurl&url=" & url))


proc siteMatrix*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
  multisync.} =
  ## Get Wikimedia sites list.
  clientify(this)
  result = parseJson(await client.getContent(
      wikipediaUrlTest & "sitematrix&smlimit=max&smsiteprop=url|dbname|code|lang|sitename"))


proc spamBlacklist*(this: Wikipedia | AsyncWikipedia, url: string): Future[
    JsonNode] {.multisync.} =
  ## Validate one or more URLs against the SpamBlacklist.
  assert url.split"|".len < 50, "Maximum number of modules is 50"
  clientify(this)
  result = parseJson(await client.getContent(
      wikipediaUrlTest & "spamblacklist&url=" & url))


# proc stabilize*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Configure review-protection settings for a page.
#   clientify(this)


# proc stashEdit*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Prepare an edit in shared cache.
#   clientify(this)


# proc strikeVote*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Allows admins to strike or unstrike a vote.
#   clientify(this)


# proc tag*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Add or remove change tags from individual revisions or log entries.
#   clientify(this)


# proc templateData*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Fetch data stored by the TemplateData extension.
#   clientify(this)


# proc thank*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Send a thank-you notification to an editor.
#   clientify(this)


proc timedText*(this: Wikipedia | AsyncWikipedia, language, title,
    trackformat: string): Future[JsonNode] {.multisync.} =
  ## Provides timed text content for usage by $lt;track> elements
  assert language.len == 2, "Language must be ISO Standard 2-Char lang code"
  assert trackformat in ["srt", "vtt"], "trackformat must be vtt or srt"
  assert title.len > 2, "title must not be empty string"
  clientify(this)
  result = parseJson(await client.getContent(
      wikipediaUrlTest & "timedtext&lang=" & language & "&title=" & title &
      "&trackformat=" & trackformat))


proc titleBlacklist*(this: Wikipedia | AsyncWikipedia, tbtitle,
    tbaction: string):
    Future[JsonNode] {.multisync.} =
  ## Validate a page title, filename, or username against the TitleBlacklist.
  assert tbaction in ["create", "edit", "upload", "createtalk", "createpage",
      "move", "new-account"]
  assert tbtitle.len > 2, "tbtitle must not be empty string"
  clientify(this)
  result = parseJson(await client.getContent(
      wikipediaUrlTest & "titleblacklist&tbnooverride=false&tbaction=" & tbaction &
      "&tbtitle=" & tbtitle))


# proc transcodeReset*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Users with the 'transcode-reset' right can reset and re-run a transcode job.
#   clientify(this)


proc ulsLocalization*(this: Wikipedia | AsyncWikipedia,
    language: string): Future[JsonNode] {.multisync.} =
  ## Get the localization of ULS in the given language.
  assert language.len == 2, "Language must be ISO Standard 2-Char lang code"
  clientify(this)
  result = parseJson(await client.getContent(
      wikipediaUrlTest & "ulslocalization&language=" & language))


# proc unblock*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Unblock a user.
#   clientify(this)


# proc undelete*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Restore revisions of a deleted page.
#   clientify(this)


# proc unlinkAccount*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Remove a linked third-party account from the current user.
#   clientify(this)


# proc upload*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Upload a file, or get the status of pending uploads.
#   clientify(this)


# proc userRights*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Change a user's group membership.
#   clientify(this)


# proc validatePassword*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Validate a password against the wiki's password policies.
#   clientify(this)


# proc visualEditor*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Returns HTML5 for a page from the Parsoid service.
#   clientify(this)


# proc visualEditorEdit*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Save an HTML5 page to MediaWiki (converted to wikitext via the Parsoid service).
#   clientify(this)


# proc watch*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.multisync.} =
#   ## Add or remove pages from the current user's watchlist.
#   clientify(this)


proc webappManifest*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
  multisync.} =
  ## Returns a WebApp Manifest.
  clientify(this)
  result = parseJson(await client.getContent(
      wikipediaUrlTest & "webapp-manifest"))


# proc wikiLove*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
#   multisync.} =
#   ## Give WikiLove to another user.
#   clientify(this)


proc zeroconfig*(this: Wikipedia | AsyncWikipedia): Future[JsonNode] {.
  multisync.} =
  ## Get configuration of the Zero extension.
  clientify(this)
  result = parseJson(await client.getContent(wikipediaUrlTest & "zeroconfig"))


when isMainModule:
  # import parseopt, terminal, random
  # {.passL: "-s", passC: "-flto -ffast-math".}
  # let wiki = Wikipedia(token: Wikipedia().login()["query"]["tokens"]["logintoken"].getStr.strip)
  let wiki = Wikipedia()
  #echo wiki.webappManifest()
  #echo wiki.zeroconfig()
  #echo wiki.ulsLocalization("en").pretty
  #echo wiki.timedText("en", "File:Example.ogv", "vtt").pretty
  # echo wiki.spamBlacklist(
  #     "https://en.wikipedia.org/w/api.php?action=spamblacklist&url=http://www.example.com/|http://www.example.org/").pretty
  #echo wiki.titleBlacklist("Foo", "edit").pretty
  #echo wiki.siteMatrix().pretty
  #echo wiki.shortenUrl("https://en.wikipedia.org/wiki/Arctica").pretty
  #echo wiki.sanitizeMapdata(parseJson("""{"foo":"bar"}""")).pretty
  echo wiki.jsonConfig(480, "status").pretty


  #discard wiki.rsd()
  #echo wiki.help(modules = "query+info|query+categorymembers").pretty
  #echo wiki.paramInfo(modules = "parse|phpfm|query%2Ballpages%7Cquery%2Bsiteinfo").pretty
