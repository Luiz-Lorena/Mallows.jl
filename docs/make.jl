using Mallows
using Documenter

DocMeta.setdocmeta!(Mallows, :DocTestSetup, :(using Mallows); recursive=true)

makedocs(;
    modules=[Mallows],
    authors="Luiz H N Lorena <luiz-lorena@hotmail.com> and contributors",
    sitename="Mallows.jl",
    format=Documenter.HTML(;
        canonical="https://luiz-lorena.github.io/Mallows.jl",
        edit_link="master",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
        "API" => "api.md",
    ],
)

deploydocs(;
    repo="github.com/luiz-lorena/Mallows.jl",
    devbranch="master",
)
