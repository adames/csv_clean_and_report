This simple application (and future gem) runs from the command line allows you to check urls in a CSV to determine success rate. It can also replace 'http' with 'https' urls in CSVs.

In order to run, simply run the bin/run file in the /bin folder. By default, it will clean the tactic.csv, output clean version to out.csv, and report on the file, but you can provide an single string argument with the relative path to your csv and it will clean/report on that csv.

Please bundle install before you run to download proper versions of each dependency.

To test, run `rake spec`.
NOTE: testing might need changes with each commit.

TODO: rake install will build and install url_reports_for_csv-0.1.0.gem into system gems
TODO: add rdocs
