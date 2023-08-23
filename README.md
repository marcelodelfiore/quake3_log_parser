# README
<h3 align="center">Quake3 Log Parser Solution</h3>

![screenshot]![Quake3 Arena Log Parser](quake3arena.png "Quake3 Arena Log Parser")

## Requirements

* This solution was developed using Ruby version 3.2.2, but any Ruby version greater than 2.7 should work.
* GIT
* Log file of Quake3 Arena

## How To Use

To clone and run this application, you'll need [Git](https://git-scm.com) installed on your computer. From your command line:

```bash
# Clone this repository
$ git clone

# Update the dependencies
$ bundle install

# Run the parser
$ ruby quake3.rb <logfile.log>
```

## Testing

There are a couple of unit tests for the classes created in this project. In order to run them all just use:

```bash
$ rspec
```

If, instead, you want to run individual unit tests for each class, just run:

```bash
$ rspec spec/lib/match_spec.rb
```

or

```bash
$ rspec spec/lib/quake3_parser_spec.rb
```
