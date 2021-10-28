# MatomoPythonLogImporter
Import logfiles without duplicates

[Matomo](https://matomo.org) is an open source web analytics tool, which is a self-hosted alternative to Google Analytics and allows anonymization of user data. 

There are multiple ways to input data into Matomo: javascript in the browser, tracking pixel and the direct import of log files from the server (e.g. apache, nginx).

## What does this tool

To import log files into Matomo, there is an import script [`import_logs.py`](https://matomo.org/docs/log-analytics-tool-how-to). 
Unfortunately there is one problem with this method: The import script just imports a logfile, but does not check if the data is allready in the Matomo Database. 
This tool, is the link between your log files and `import_logs.py`

MatomoPythonLogImporter checks if there is new data in the logfile, and only submits new data to Matomo.


## Setup

1. Copy this repository into the Matomo folder, e.g. `/matomo/MatomoPythonLogImporter`
2. Edit the paths in [`config.sh`](https://github.com/ganti/MatomoPythonLogImporter/blob/main/config.sh)

3. Edit [`config_matomo.config`](https://github.com/ganti/MatomoPythonLogImporter/blob/main/config_matomo.config)
The format should be `{website.log}={MatomoSiteID}` . It is possibile to connect multiple log files to one Matomo [Site ID](https://matomo.org/faq/general/faq_19212/) 

4. Set up a cronjob:  
The following example runs the importer every 5 minutes
```sh
*/5 * * * * /usr/bin/sh […]/matomo/MatomoPythonLogImporter/log_importer.sh
```

## Closing remarks
This bash script ist pretty straight forward and it should be possible to adapt it fairly quickly to your webserver settings. It is highly recommended to create a test website in matomo, and run the script with one logfile, before addding all domains of your server.

Do whatever you desire with this code. If you find a bug or have an improvement let me know in an issue or pull request

### License
[CC0 1.0 Universal  (CC0 1.0)  Public Domain Dedication](https://creativecommons.org/publicdomain/zero/1.0/) 
