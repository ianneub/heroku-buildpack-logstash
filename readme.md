# Heroku Buildpack for Logstash

This buildpack sets up a basic environment to run Logstash in.

## Requirements

You will need a file in your root folder named `logstash.conf`. This file should contain your logstash configuration information.

See an example `logstash.conf` in the [wiki](https://github.com/ianneub/heroku-buildpack-logstash/wiki).

## Usage

To create a new Heroku app use the following commands:

1. `heroku create --buildpack https://github.com/ianneub/heroku-buildpack-logstash.git`
1. `git push heroku`

## Settings

You can configure the version of and/or the url to download Logstash from using a `config.json` file in your project root.

```json
{
    "logstash": {
        "version": "1.2.1",
        "url": "https://download.elasticsearch.org/logstash/logstash/logstash-1.2.1-flatjar.jar",
        "debug": true
    }
}
```

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
