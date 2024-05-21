# pwd() 命令可查看当前工作路径
# cd(dir::String) 更换路径

using DataFrames, AlgebraOfGraphics, CairoMakie, Glob, Colors, LaTeXStrings, Dierckx, ColorSchemes

using CSV

folder = raw"I:\julia\20240516 501 532 531\531" 
files = glob("*.csv", folder) 

folder_id = basename(folder)

df = DataFrame() 

for i in files
    curve_name = splitext(basename(i))[1]
    df_temp = CSV.read.(
            i,
            DataFrame,
            header=255,
            select=[2,6],
            missingstring="NA",
        )
    x = df_temp." V1"
    y = df_temp." Jdensity"
    spl = Spline1D(x, y; k=5)
    D1f = derivative(spl, x; nu=1)
    insertcols!(df_temp, :c => 1 ./ abs.(D1f))
    insertcols!(df_temp, :d =>curve_name)
    append!(df, df_temp)

end


# println(df)


# CairoMakie.activate!()
# # A vector can be defined as the sequence of data with the same datatype.
# # We can concatenate any number of objects together, as long as they are the same type


# Plot Data

ra = data(df) * mapping(" V1", "c", color="d",) * visual(Lines)

jv = data(df) * mapping(" V1", " Jdensity", color=:"d",) * visual(Lines)


fig = Figure(; size=(1400,500))

subfig1 = draw!(fig[1, 1], jv;
    axis=(;
        title=string(folder_id)*" | 77 K" ,
        titlealign = :center,
        # titlefont = "DejaVu Sans Mono",
        # titlegap = -300,
        yscale=log10,
        xlabel=L"Gate voltage $(V)$",
        ylabel=L"Dark current density $(A/cm^2)$",
        # aspect =  10/10,
        xticks = -0.8:0.2:0.5,
        limits=((-0.8,0.5),(nothing, nothing)),
    ),
)

subfig2 = draw!(fig[1, 3], ra;
    axis=(;
        title=string(folder_id)*" | 77 K" ,
        titlealign = :center,
        # titlefont = "DejaVu Sans Mono",
        # titlegap = -300,
        yscale=log10,
        xlabel=L"Gate voltage $(V)$",
        ylabel=L"R*A $(\Omega\cdot cm^2)$",
        # aspect =  10/10,
        xticks = -0.8:0.2:0.5,
        limits=((-0.8,0.5),(nothing, nothing)),
    ),
    # palettes=(; color=ColorSchemes.Set1_9.colors)
)



legend!(
    fig[1,2],
    subfig1;
    orientation=:vertical,
    tellheight=false,
    framevisible=false, 
    padding=0, 
    patchsize=(20,10)
)


legend!(
    fig[1,4],
    subfig2;
    orientation=:vertical,
    tellheight=false,
    framevisible=false, 
    padding=0, 
    patchsize=(20,10)
)

# draw(jv,
# axis=(;
#     title=string(folder_id)*" | 77 K" ,
#     titlealign = :center,
#     # titlefont = "DejaVu Sans Mono",
#     # titlegap = -300,
#     yscale=log10,
#     xlabel=L"Gate voltage $(V)$",
#     ylabel=L"Dark current density $(A/cm^2)$",
#     # aspect =  10/10,
#     xticks = -0.8:0.2:0.5,
#     limits=((-0.8,0.5),(10^(-8), 10^4)),
# ),
# legend=(position=:right, titleposition=:top, framevisible=false, padding=0, patchsize=(20,10)),
# )


# save(string(folder_id)*"_JV.png", fig; px_per_unit=10.0)



# draw(ra,
# axis=(;
#     title=string(folder_id)*" | 77 K" ,
#     titlealign = :center,
#     # titlefont = "DejaVu Sans Mono",
#     # titlegap = -300,
#     yscale=log10,
#     xlabel=L"Gate voltage $(V)$",
#     ylabel=L"R*A $(\Omega\cdot cm^2)$",
#     # aspect =  10/10,
#     # xticks = -0.8:0.2:0.5,
#     # limits=((-0.8,0.5),(10^(-8), 10^4)),
# ),
# legend=(position=:right, titleposition=:top, framevisible=false, padding=0, patchsize=(20,10)),
# )

save(string(folder_id)*".png", fig)


fig




#  核心操作点： 如何绘制 multi curve，已经解决，先 Vcat csv 文件，再AoG 结合 Makie 绘图
#  如何创建类似excel的数据库
# axis 选项中 xlabel=L"r [r_{\mathrm{Sch}}]"，可输入数学格式