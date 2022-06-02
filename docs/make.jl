using Smartphores
using Documenter

DocMeta.setdocmeta!(Smartphores, :DocTestSetup, :(using Smartphores); recursive=true)

makedocs(;
    modules=[Smartphores],
    authors="Joris Pinkse <pinkse@gmail.com> and contributors",
    repo="https://github.com/NittanyLion/Smartphores.jl/blob/{commit}{path}#{line}",
    sitename="Smartphores.jl",
    format=Documenter.HTML(;
        prettyurls=get(ENV, "CI", "false") == "true",
        canonical="https://NittanyLion.github.io/Smartphores.jl",
        edit_link="main",
        assets=String[],
    ),
    pages=[
        "Home" => "index.md",
    ],
)

deploydocs(;
    repo="github.com/NittanyLion/Smartphores.jl",
    devbranch="main",
)
