using DICOMClient
using Documenter

makedocs(;
    modules=[DICOMClient],
    authors="Dilum Aluthge, Brown Center for Biomedical Informatics, JuliaHealth organization, contributors",
    repo="https://github.com/JuliaHealth/DICOMClient.jl/blob/{commit}{path}#L{line}",
    sitename="DICOMClient.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://JuliaHealth.github.io/DICOMClient.jl",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "Examples" => "examples.md",
        "API" => "api.md"
    ],
    strict = true,
)

deploydocs(;
    repo="github.com/JuliaHealth/DICOMClient.jl",
)
