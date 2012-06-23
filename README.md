# dir-util

dir-util is just a collection of simple and useful utility methods for operating on directories on the filesystem.

## Requirements/Installation

dir-util depends on ```fileutils``` being available. In test, it relies on rspec and either rcov (Ruby 1.8) or simplecov (Ruby 1.9).

Install the gem: ```gem install dir-util-(version).gem```

## Running the tests:

```rake spec```

## Building the gem:

```rake gem:build```

## Install gem with Rake:

```rake gem:install```

## Usage

### to\_all\_files

I've found that I often want to do something to every file contained in a directory tree (ie, in the directory and all its subdirectories, all the way down until all the subdirectories are exhausted).

For example, I recently wrote a program that went through a directory and found all the image files, processed them, and moved them out to another location.

```ruby
DirUtil.to_all_files("~/Documents") do |filename|
    puts filename
end
```

The block is passed recursively to every subdirectory.

The way I think about the naming for this one is "to all files <in here> do <this>".

### subdirectories

Sometimes you just want to know all the subdirectories under a directory.

```ruby
DirUtil.subdirectories("~") == ["/Users/sirsean/Documents", "/Users/sirsean/Desktop", "/Users/sirsean/Documents/sub1", "/Users/sirsean/Desktop/sub2"]
```

The list you get back is ordered such that all the top-level subdirectories come first; basically, if you wanted to delete all the subdirectories, you'd want to reverse the list first.

##License

See the LICENSE file. Licensed under the Apache 2.0 License
