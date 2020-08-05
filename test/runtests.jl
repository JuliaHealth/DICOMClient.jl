using DICOMClient

using Documenter
using FileIO
using ImageMagick
using Images
using JSON3
using HTTP
using ReferenceTests
using Test

DICOMCLIENT_AUTHENTICATED_TESTS = get(ENV, "DICOMCLIENT_AUTHENTICATED_TESTS", "") == "true"
@info("DICOMCLIENT_AUTHENTICATED_TESTS: $(DICOMCLIENT_AUTHENTICATED_TESTS)")

include("test-utilities.jl")

@testset "DICOMCLIENT.jl" begin
    @testset "Unit tests" begin
        include("unit-tests.jl")
    end
    @testset "Doctests" begin
        doctest(DICOMClient)
    end
    @testset "Integration tests" begin
        @testset "Integration tests: unauthenticated" begin
            include("integration-tests/unauthenticated-integration-tests/basic-test.jl")
        end
        if DICOMCLIENT_AUTHENTICATED_TESTS
            @info("DICOMCLIENT_AUTHENTICATED_TESTS is true. Running the authenticated tests now...")
            @testset "Integration tests: authenticated" begin
            end
        else
            @info("DICOMCLIENT_AUTHENTICATED_TESTS is not true, so we will not run the authenticated tests.")
        end
    end
end
