using Pkg
Pkg.add(["DataFrames", "RDatasets", "DataFramesMeta", "CategoricalArrays", "Query", "VegaLite", "GLM"])

using LinearAlgebra, Statistics
using DataFrames, RDatasets, DataFramesMeta, CategoricalArrays, Query, VegaLite
using GLM

x=randn(100)
y=0.9.*x+0.5.*randn(100)
df=DataFrame(x=x,y=y)
ols=lm(@formula(y~x),df)
Pkg.add("RegressionTables")
Pkg.add("FixedEffectModels")
using RegressionTables, FixedEffectModels
regtable(ols)
df = dataset("datasets", "iris")
df[!,:SpeciesDummy] = categorical(df[!,:Species])

rr1 = reg(df, @formula(SepalLength ~ SepalWidth + fe(SpeciesDummy)))
rr2 = reg(df, @formula(SepalLength ~ SepalWidth + PetalLength + fe(SpeciesDummy)))
rr3 = reg(df, @formula(SepalLength ~ SepalWidth + PetalLength + PetalWidth + fe(SpeciesDummy)))
rr4 = reg(df, @formula(SepalWidth ~ SepalLength + PetalLength + PetalWidth + fe(SpeciesDummy)))

regtable(rr1,rr2,rr3,rr4; renderSettings = asciiOutput())
regtable(rr1,rr2,rr3,rr4; renderSettings = latexOutput())

b=(x'x)\(x'y)



sdfdsfds