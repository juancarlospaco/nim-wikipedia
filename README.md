# Wikipedia

- Wikipedia & Wikimedia Async Standalone Single-file API Lib & App, Pretty-Printed JSON output.


# Features

- All Wikipedia API is supported, except Deprecated, Internal and Unstable calls.
- Check the Wikipedia Documentation Wiki, the Lib is a 1:1 copy of the official Docs.
- This Library uses API as from Year 2019.
- All procs return `JsonNode` Object.
- The order of the procs follows the order on the Wikipedia Documentation Wiki.
- The naming of the procs follows the naming on the Wikipedia Documentation Wiki.
- The errors on the procs follows the errors on the Wikipedia Documentation Wiki.
- API Calls use the DoNotTrack HTTP Header.
- The `timeout` argument is on Seconds.
- For Proxy support define a proxy of `Proxy` type.
- No OS-specific code, so it should work on Linux, Windows and Mac.


# Install

- ???


# Dependencies

- **None**


# Platforms

- ✅ Linux
- ✅ Windows
- ✅ Mac
- ✅ Android
- ✅ Raspberry Pi
- ✅ BSD


# FAQ

- Developer Documentation ?.

`nim doc wikipedia.nim`

- Coding Style Guide ?.

`nimpretty wikipedia.nim`

- Linter ?.

`nim check --styleCheck:hint wikipedia.nim`

- This works with Asynchronous code ?.

Yes.

- This works with Synchronous code ?.

Yes.

- This works without SSL ?.

No.

- This requires Wikipedia account ?.

No. But is recommended to have one whatsoever, is an awesome project.

- Are Deprecated endpoints supported ?.

No.

- Can I use a Sandbox fake server for testing purposes ?.

Yes. The Testing server mirror of Wikipedia is provided on a string const.

- I dont like some of the naming ?.

Me neither.

But it follows Wikipedia API Designs. 🤷‍

- An specific API Endpoint randomly fails ?.

Some endpoints are marked as "This module is internal or unstable. Its operation may change without notice."

Technical Documentation of Wikipedia API is scarce.

Not my Bug.
