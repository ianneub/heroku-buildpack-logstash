# Heroku Buildpack for Steller Logstash

This buildpack sets up a basic environment to run Logstash in. It is not a general purpose
buildback in that it contains both the code, configuration, and patches to run logstash in
the steller configuration.

The repo uses bad-form in that it carries the full tar.gz distribution of the logstash bits
rather than downloading them on each push.

This build pack includes a custom patched s3 input filter that uses s3 to store its sincedb. The
stock s3 filter uses a local filesystem which is incompatible with heroku. A pull request has been
submitted, but until then, we just unzip and then patch the standard s3 input filter.

# Index Rebuilding

There are times when you are going to want/need to rebuild one or more indicies. E.g., when enhancing
the logstash configs, or when changing index properties, etc.

The first step of doing this is understanding which set of raw S3 logs need to be re-indexed and what the datestamp
is on the last log that is NOT to be part of the index.

The logstash process uses the sincedb file in papertrail.steller.co/sincedb as the timestamp of the last file
that it has processed. Set this file to a few minutes after the last file thats part of the last index to
be preserved. E.g., if you are rebuilding indicies for 4/18 and beyond, look at the last file in the
dt=2014-04-17 bucket and upload a new sincedb with that files modified time (+ a few minutes). This will ensure
that this file is not processed and that the next one that is is also the beginning of a new index boundary. A
typical sincedb will look like: "2014-04-17 20:07:00 -0700"

* Stop the steller-logstash process with: heroku ps:scale worker=0 --app steller-logstash
* go to found.no and delete indicies that need to be rebuilt
* upload a new version of sincedeb into papertrail.steller.co/sincedb
* Restart steller-logstash with: heroku ps:scale worker=1 --app steller-logstash

# License

The MIT License (MIT)

Copyright (c) 2013 Ian Neubert

Permission is hereby granted, free of charge, to any person obtaining a copy
of this software and associated documentation files (the "Software"), to deal
in the Software without restriction, including without limitation the rights
to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
copies of the Software, and to permit persons to whom the Software is
furnished to do so, subject to the following conditions:

The above copyright notice and this permission notice shall be included in
all copies or substantial portions of the Software.

THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
THE SOFTWARE.
