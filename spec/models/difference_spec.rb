require 'spec_helper'

# describe Distance do
#   describe("#plugins") do
#     it "returns the intersection between the plugins of the two fingerprints" do
#       some_fun_name = double(plugins: ["foo", "bar"])
#       some_other_fun_name = double(plugins: ["bar", "baz"])
#       third_fun_name = double(plugins: ["foo", "bar", "baz"])
#
#       expect(Difference.new(some_fun_name, some_other_fun_name).plugins).to eq(["bar"])
#       expect(Difference.new(some_fun_name, thrid_fun_name).plugins).to eq(["foo", "bar"])
#       expect(Difference.new(some_other_fun_name, third_fun_name).plugins).to eq(["bar", "baz"])
#     end
#   end
#
#   describe("#plugins_difference") do
#     it("returns the levenshtein calculator for the two fingerprings") do
#       fingerprint = double(plugins: ["foo", "bar"])
#       other = double(plugins: ["bar", "baz"])
#
#       difference = Difference.new(fingerprint, other)
#
#       expect(difference.plugins_distance).to eq(PluginsDifference.new(["foo", "bar"], ["bar", "baz"]))
#     end
#   end
# end
