# Heroku Buildpack for Steller Logstash

This buildpack sets up a basic environment to run Logstash in. It is not a general purpose
buildback in that it contains both the code, configuration, and patches to run logstash in
the steller configuration.

The repo uses bad-form in that it carries the full tar.gz distribution of the logstash bits
rather than downloading them on each push.

This build pack includes a custom patched s3 input filter that uses s3 to store its sincedb. The
stock s3 filter uses a local filesystem which is incompatible with heroku. A pull request has been
submitted, but until then, we just unzip and then patch the standard s3 input filter.

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
