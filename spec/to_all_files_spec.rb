require "spec_helper"
require "fileutils"

describe DirUtil do
    before :all do
        @scratch = File.join(File.dirname(__FILE__), "testscratch")
    end

    before :each do
        FileUtils.makedirs(@scratch)
    end

    after :each do
        FileUtils.rm_rf(@scratch)
    end

    context "to all files" do
        it "when directory is empty" do
            files = []
            DirUtil.to_all_files(@scratch) do |filename|
                files << filename
            end
            files.count.should == 0
        end

        it "when there is one file" do
            FileUtils.touch(File.join(@scratch, "file1"))
            files = []
            DirUtil.to_all_files(@scratch) do |filename|
                files << filename
            end
            files.should == [File.join(@scratch, "file1")]
        end

        it "when there are multiple files in one level" do
            FileUtils.touch(File.join(@scratch, "file1"))
            FileUtils.touch(File.join(@scratch, "file2"))
            FileUtils.touch(File.join(@scratch, "file3"))
            files = []
            DirUtil.to_all_files(@scratch) do |filename|
                files << filename
            end
            files.should == [
                File.join(@scratch, "file1"),
                File.join(@scratch, "file2"),
                File.join(@scratch, "file3"),
                ]
        end

        it "when there are multiple levels of subdirectories" do
            FileUtils.makedirs(File.join(@scratch, "sub1", "sub2"))
            FileUtils.touch(File.join(@scratch, "file1"))
            FileUtils.touch(File.join(@scratch, "sub1", "file2"))
            FileUtils.touch(File.join(@scratch, "sub1", "sub2", "file3"))
            FileUtils.touch(File.join(@scratch, "sub1", "sub2", "file4"))
            files = []
            DirUtil.to_all_files(@scratch) do |filename|
                files << filename
            end
            files.should == [
                File.join(@scratch, "file1"),
                File.join(@scratch, "sub1", "file2"),
                File.join(@scratch, "sub1", "sub2", "file3"),
                File.join(@scratch, "sub1", "sub2", "file4"),
                ]
        end

        it "when there are multiple levels of subdirectories and you pass a Dir object" do
            FileUtils.makedirs(File.join(@scratch, "sub1", "sub2"))
            FileUtils.touch(File.join(@scratch, "file1"))
            FileUtils.touch(File.join(@scratch, "sub1", "file2"))
            FileUtils.touch(File.join(@scratch, "sub1", "sub2", "file3"))
            FileUtils.touch(File.join(@scratch, "sub1", "sub2", "file4"))
            files = []
            DirUtil.to_all_files(Dir.new(@scratch)) do |filename|
                files << filename
            end
            files.should == [
                File.join(@scratch, "file1"),
                File.join(@scratch, "sub1", "file2"),
                File.join(@scratch, "sub1", "sub2", "file3"),
                File.join(@scratch, "sub1", "sub2", "file4"),
                ]
        end
    end
end
