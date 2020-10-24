using Pkg

# Pkg.activate(".")
Pkg.add("PyCall")
withenv("PYTHON" => "") do
   Pkg.build("PyCall")
end
Pkg.add(PackageSpec(url="https://github.com/JuliaML/OpenAIGym.jl.git"))
