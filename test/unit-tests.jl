using DICOMClient

using HTTP
using Test

@testset "version" begin
    @test DICOMClient.package_version() isa VersionNumber
    @test DICOMClient.package_version() > v"0"
end

@testset "_add_trailing_slash" begin
    @test DICOMClient._add_trailing_slash(HTTP.URI("https://juliahealth.org")) == HTTP.URI("https://juliahealth.org/")
    @test DICOMClient._add_trailing_slash(HTTP.URI("https://juliahealth.org/")) == HTTP.URI("https://juliahealth.org/")
end

@testset "parse_multipart_image" begin
    @test_throws ArgumentError DICOMClient.parse_multipart_image(Val(:jpeg), UInt8[0xff, 0xd8, 0xff, 0xd9, 0xff, 0xd8])
end
