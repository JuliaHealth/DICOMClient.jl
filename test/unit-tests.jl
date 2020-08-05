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
