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

    context "subdirectories" do
        it "when the directory is empty" do
            DirUtil.subdirectories(@scratch).should == []
        end

        it "when there are files but no subdirectories" do
            FileUtils.touch(File.join(@scratch, "file1"))
            DirUtil.subdirectories(@scratch).should == []
        end

        it "when there is one subdirectory" do
            FileUtils.makedirs(File.join(@scratch, "sub1"))
            DirUtil.subdirectories(@scratch).should == [
                File.join(@scratch, "sub1")
            ]
        end

        it "when there are multiple subdirectories" do
            FileUtils.makedirs(File.join(@scratch, "sub1"))
            FileUtils.makedirs(File.join(@scratch, "sub2"))
            DirUtil.subdirectories(@scratch).should == [
                File.join(@scratch, "sub1"),
                File.join(@scratch, "sub2"),
            ]
        end

        it "when there are multiple levels of subdirectories" do
            FileUtils.makedirs(File.join(@scratch, "sub1", "sub11"))
            FileUtils.makedirs(File.join(@scratch, "sub1", "sub12"))
            FileUtils.makedirs(File.join(@scratch, "sub2", "sub22", "sub222"))
            FileUtils.makedirs(File.join(@scratch, "sub3"))
            DirUtil.subdirectories(@scratch).should == [
                File.join(@scratch, "sub1"),
                File.join(@scratch, "sub2"),
                File.join(@scratch, "sub3"),
                File.join(@scratch, "sub1", "sub11"),
                File.join(@scratch, "sub1", "sub12"),
                File.join(@scratch, "sub2", "sub22"),
                File.join(@scratch, "sub2", "sub22", "sub222"),
            ]
        end

        it "when there are multiple levels of subdirectories and you pass a Dir object" do
            FileUtils.makedirs(File.join(@scratch, "sub1", "sub11"))
            FileUtils.makedirs(File.join(@scratch, "sub1", "sub12"))
            FileUtils.makedirs(File.join(@scratch, "sub2", "sub22", "sub222"))
            FileUtils.makedirs(File.join(@scratch, "sub3"))
            DirUtil.subdirectories(Dir.new(@scratch)).should == [
                File.join(@scratch, "sub1"),
                File.join(@scratch, "sub2"),
                File.join(@scratch, "sub3"),
                File.join(@scratch, "sub1", "sub11"),
                File.join(@scratch, "sub1", "sub12"),
                File.join(@scratch, "sub2", "sub22"),
                File.join(@scratch, "sub2", "sub22", "sub222"),
            ]
        end
    end
end
