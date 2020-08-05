using DICOMClient

using FileIO
using ImageMagick
using Images
using JSON3
using ReferenceTests
using Test

@testset "Basic test" begin
    study = "1.2.156.112536.1.2116.222245005117096205.13585270080.1"
    series = "1.2.156.112536.1.2116.222245005117096205.13585270080.2"
    instance = "1.2.156.112536.1.2116.222245005117096205.13585271850.5"
    frames = 1:1
    anonymous_auth = DICOMClient.AnonymousAuth()
    all_auths = [
        anonymous_auth,
    ]
    for auth in all_auths
        base_url = DICOMClient.BaseURL("https://dicomcloud.azurewebsites.net/api")
        client = DICOMClient.Client(base_url, auth)
        @test DICOMClient.get_auth(client) == auth
        @test DICOMClient.get_base_url(client) == base_url
        all_studies_json = DICOMClient.get_all_studies(client)
        @test all_studies_json isa AbstractVector
        all_series_json = DICOMClient.get_all_series(client;
                                                     study = study)
        @test all_series_json isa AbstractVector
        all_instances_json = DICOMClient.get_all_instances(client;
                                                           study = study,
                                                           series = series)
        @test all_instances_json isa AbstractVector
        single_instance_metadata = DICOMClient.get_single_instance_metadata(client;
                                                                            study = study,
                                                                            series = series,
                                                                            instance = instance)
        @test all_instances_json isa AbstractVector
        images = DICOMClient.get_frame_images(Val(:jpeg),
                                              client;
                                              study = study,
                                              series = series,
                                              instance = instance,
                                              frames = frames)
        julia_version_to_expected_hashes = Dict(
            v"1.5" => [0x0f638ae086d9a3c8, 0x0f638ae086d9a3c8],
            v"1.6" => [0x0f638ae086d9a3c8, 0x0f638ae086d9a3c8],
            v"1" =>   [0x0f638ae086d9a3c8, 0x0f638ae086d9a3c8],
        )
        expected_hashes = _get_expected_hashes(julia_version_to_expected_hashes, Base.VERSION)
        @test images isa AbstractVector
        @test length(images) == 2
        for j = 1:2
            @test images[j] isa Matrix{<:RGB}
            @test size(images[j]) == (910, 1260)
            @test hash(images[j]) == expected_hashes[j]
        end
        Base.shred!(auth)
        Base.shred!(client)
    end
    for i in 1:length(all_auths)
        Base.shred!(all_auths[i])
    end
end
